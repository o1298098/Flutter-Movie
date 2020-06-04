import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/actions/apihelper.dart';
import 'package:movie/models/videolist.dart';
import 'action.dart';
import 'state.dart';

Effect<DiscoverPageState> buildEffect() {
  return combineEffects(<Object, Effect<DiscoverPageState>>{
    DiscoverPageAction.action: _onAction,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
    DiscoverPageAction.videoCellTapped: _onVideoCellTapped,
    DiscoverPageAction.refreshData: _onLoadData,
    DiscoverPageAction.mediaTypeChange: _mediaTypeChange,
  });
}

void _onAction(Action action, Context<DiscoverPageState> ctx) {}

Future _onInit(Action action, Context<DiscoverPageState> ctx) async {
  ctx.state.scrollController = ScrollController();
  ctx.state.filterState.keyWordController = TextEditingController();
  ctx.state.scrollController.addListener(() async {
    bool isBottom = ctx.state.scrollController.position.pixels ==
        ctx.state.scrollController.position.maxScrollExtent;
    if (isBottom) {
      await _onLoadMore(action, ctx);
    }
  });
  await _onLoadData(action, ctx);
}

void _onDispose(Action action, Context<DiscoverPageState> ctx) {
  ctx.state.scrollController.dispose();
  ctx.state.filterState.keyWordController.dispose();
  ctx.state.dropdownMenuController.dispose();
}

Future _onLoadData(Action action, Context<DiscoverPageState> ctx) async {
  ctx.dispatch(DiscoverPageActionCreator.onBusyChanged(true));
  final _genres = ctx.state.filterState.isMovie
      ? ctx.state.filterState.movieGenres
      : ctx.state.filterState.tvGenres;
  var genresIds = _genres.where((e) => e.isSelected).map<int>((e) {
    return e.value;
  }).toList();
  VideoListModel r;
  if (ctx.state.filterState.isMovie)
    r = await ApiHelper.getMovieDiscover(
        withKeywords: ctx.state.filterState.keyWordController.text,
        sortBy: ctx.state.selectedSort,
        withGenres: genresIds.length > 0 ? genresIds.join(',') : null);
  else
    r = await ApiHelper.getTVDiscover(
        withKeywords: ctx.state.filterState.keyWordController.text,
        sortBy: ctx.state.selectedSort,
        withGenres: genresIds.length > 0 ? genresIds.join(',') : null);
  if (r != null) ctx.dispatch(DiscoverPageActionCreator.onLoadData(r));

  ctx.dispatch(DiscoverPageActionCreator.onBusyChanged(false));
}

Future _onVideoCellTapped(Action action, Context<DiscoverPageState> ctx) async {
  if (ctx.state.filterState.isMovie)
    await Navigator.of(ctx.context).pushNamed('detailpage',
        arguments: {'id': action.payload[0], 'bgpic': action.payload[1]});
  else
    await Navigator.of(ctx.context).pushNamed('tvdetailpage',
        arguments: {'tvid': action.payload[0], 'bgpic': action.payload[1]});
}

Future _onLoadMore(Action action, Context<DiscoverPageState> ctx) async {
  if (ctx.state.isbusy) return;
  ctx.dispatch(DiscoverPageActionCreator.onBusyChanged(true));
  final _genres = ctx.state.filterState.isMovie
      ? ctx.state.filterState.movieGenres
      : ctx.state.filterState.tvGenres;
  var genresIds = _genres.where((e) => e.isSelected).map<int>((e) {
    return e.value;
  }).toList();
  VideoListModel r;
  if (ctx.state.filterState.isMovie)
    r = await ApiHelper.getMovieDiscover(
        page: ctx.state.videoListModel.page + 1,
        sortBy: ctx.state.selectedSort,
        withGenres: genresIds.length > 0 ? genresIds.join(',') : null,
        withKeywords: ctx.state.filterState.keywords);
  else
    r = await ApiHelper.getTVDiscover(
        page: ctx.state.videoListModel.page + 1,
        sortBy: ctx.state.selectedSort,
        withGenres: genresIds.length > 0 ? genresIds.join(',') : null,
        withKeywords: ctx.state.filterState.keywords);
  if (r != null) ctx.dispatch(DiscoverPageActionCreator.onLoadMore(r.results));
  ctx.dispatch(DiscoverPageActionCreator.onBusyChanged(false));
}

Future _mediaTypeChange(Action action, Context<DiscoverPageState> ctx) async {
  final bool _isMovie = action.payload ?? true;
  if (ctx.state.filterState.isMovie == _isMovie) return;
  ctx.state.filterState.isMovie = _isMovie;
  await _onLoadData(action, ctx);
  ctx.state.scrollController.jumpTo(0);
}
