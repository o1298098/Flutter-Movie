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
    DiscoverPageAction.videoCellTapped: _onVideoCellTapped,
    DiscoverPageAction.refreshData: _onLoadData,
  });
}

void _onAction(Action action, Context<DiscoverPageState> ctx) {}

Future _onInit(Action action, Context<DiscoverPageState> ctx) async {
  ctx.state.scrollController = new ScrollController();
  ctx.state.scrollController.addListener(() async {
    bool isBottom = ctx.state.scrollController.position.pixels ==
        ctx.state.scrollController.position.maxScrollExtent;
    if (isBottom) {
      await _onLoadMore(action, ctx);
    }
  });
  await _onLoadData(action, ctx);
}

Future _onLoadData(Action action, Context<DiscoverPageState> ctx) async {
  ctx.dispatch(DiscoverPageActionCreator.onBusyChanged(true));
  var genresIds =
      ctx.state.filterState.genres.where((e) => e.isSelected).map<int>((e) {
    return e.value;
  }).toList();
  VideoListModel r;
  if (ctx.state.filterState.isMovie)
    r = await ApiHelper.getMovieDiscover(
        sortBy: ctx.state.selectedSort,
        withGenres: genresIds.length > 0 ? genresIds.join(',') : null);
  else
    r = await ApiHelper.getTVDiscover(
        sortBy: ctx.state.selectedSort,
        withGenres: genresIds.length > 0 ? genresIds.join(',') : null);
  if (r != null) ctx.dispatch(DiscoverPageActionCreator.onLoadData(r));
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
  ctx.dispatch(DiscoverPageActionCreator.onBusyChanged(true));
  var genresIds =
      ctx.state.filterState.genres.where((e) => e.isSelected).map<int>((e) {
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
}
