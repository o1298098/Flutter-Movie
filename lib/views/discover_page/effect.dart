import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/actions/api/tmdb_api.dart';
import 'package:movie/models/response_model.dart';
import 'package:movie/models/video_list.dart';
import 'action.dart';
import 'state.dart';

Effect<DiscoverPageState> buildEffect() {
  return combineEffects(<Object, Effect<DiscoverPageState>>{
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
    DiscoverPageAction.action: _onAction,
    DiscoverPageAction.videoCellTapped: _onVideoCellTapped,
    DiscoverPageAction.refreshData: _onLoadData,
    DiscoverPageAction.mediaTypeChange: _mediaTypeChange,
    DiscoverPageAction.filterTap: _filterTap,
    DiscoverPageAction.applyFilter: _applyFilter,
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
}

Future _onLoadData(Action action, Context<DiscoverPageState> ctx) async {
  ctx.dispatch(DiscoverPageActionCreator.onBusyChanged(true));
  final _genres = ctx.state.currentGenres;
  var genresIds = _genres.where((e) => e.isSelected).map<int>((e) {
    return e.value;
  }).toList();
  ResponseModel<VideoListModel> r;
  String _sortBy = ctx.state.selectedSort == null
      ? null
      : '${ctx.state.selectedSort.value}${ctx.state.sortDesc ? '.desc' : '.asc'}';
  final _tmdb = TMDBApi.instance;
  if (ctx.state.isMovie)
    r = await _tmdb.getMovieDiscover(
        voteAverageGte: ctx.state.lVote,
        voteAverageLte: ctx.state.rVote,
        sortBy: _sortBy,
        withGenres: genresIds.length > 0 ? genresIds.join(',') : null);
  else
    r = await _tmdb.getTVDiscover(
        voteAverageGte: ctx.state.lVote,
        voteAverageLte: ctx.state.rVote,
        withKeywords: ctx.state.filterState.keyWordController.text,
        sortBy: _sortBy,
        withGenres: genresIds.length > 0 ? genresIds.join(',') : null);
  if (r.success) ctx.dispatch(DiscoverPageActionCreator.onLoadData(r.result));

  ctx.dispatch(DiscoverPageActionCreator.onBusyChanged(false));
  ctx.state.scrollController?.jumpTo(0);
}

Future _onVideoCellTapped(Action action, Context<DiscoverPageState> ctx) async {
  if (ctx.state.isMovie)
    await Navigator.of(ctx.context).pushNamed(
      'detailpage',
      arguments: {'id': action.payload[0], 'bgpic': action.payload[1]},
    );
  else
    await Navigator.of(ctx.context).pushNamed('tvShowDetailPage', arguments: {
      'id': action.payload[0],
      'bgpic': action.payload[1],
      'posterpic': action.payload[2],
      'name': action.payload[3]
    });
}

Future _onLoadMore(Action action, Context<DiscoverPageState> ctx) async {
  if (ctx.state.isbusy) return;
  ctx.dispatch(DiscoverPageActionCreator.onBusyChanged(true));
  final _genres = ctx.state.filterState.currentGenres;
  var genresIds = _genres.where((e) => e.isSelected).map<int>((e) {
    return e.value;
  }).toList();
  ResponseModel<VideoListModel> r;
  String _sortBy = ctx.state.selectedSort == null
      ? null
      : '${ctx.state.selectedSort?.value ?? ''}${ctx.state.filterState.sortDesc ? '.desc' : '.asc'}';
  final _tmdb = TMDBApi.instance;
  if (ctx.state.isMovie)
    r = await _tmdb.getMovieDiscover(
      voteAverageGte: ctx.state.lVote,
      voteAverageLte: ctx.state.rVote,
      page: ctx.state.videoListModel.page + 1,
      sortBy: _sortBy,
      withGenres: genresIds.length > 0 ? genresIds.join(',') : null,
    );
  else
    r = await _tmdb.getTVDiscover(
        voteAverageGte: ctx.state.lVote,
        voteAverageLte: ctx.state.rVote,
        page: ctx.state.videoListModel.page + 1,
        sortBy: _sortBy,
        withGenres: genresIds.length > 0 ? genresIds.join(',') : null,
        withKeywords: ctx.state.filterState.keywords);
  if (r.success)
    ctx.dispatch(DiscoverPageActionCreator.onLoadMore(r.result.results));
  ctx.dispatch(DiscoverPageActionCreator.onBusyChanged(false));
}

Future _mediaTypeChange(Action action, Context<DiscoverPageState> ctx) async {
  final bool _isMovie = action.payload ?? true;
  if (ctx.state.isMovie == _isMovie) return;
  ctx.state.isMovie = _isMovie;
  ctx.state.currentGenres = _isMovie
      ? ctx.state.filterState.movieGenres
      : ctx.state.filterState.tvGenres;
  await _onLoadData(action, ctx);
}

void _filterTap(Action action, Context<DiscoverPageState> ctx) async {
  ctx.state.filterState.isMovie = ctx.state.isMovie;
  ctx.state.filterState.selectedSort = ctx.state.selectedSort;
  ctx.state.filterState.currentGenres = ctx.state.currentGenres;
  ctx.state.filterState.lVote = ctx.state.lVote;
  ctx.state.filterState.rVote = ctx.state.rVote;
  Navigator.of(ctx.context)
      .push(PageRouteBuilder(pageBuilder: (_, animation, ___) {
    return SlideTransition(
        position: Tween<Offset>(begin: Offset(0, 1), end: Offset.zero)
            .animate(CurvedAnimation(parent: animation, curve: Curves.ease)),
        child: FadeTransition(
            opacity: animation, child: ctx.buildComponent('filter')));
  }));
}

void _applyFilter(Action action, Context<DiscoverPageState> ctx) {
  ctx.state.currentGenres = ctx.state.filterState.currentGenres;
  ctx.state.selectedSort = ctx.state.filterState.selectedSort;
  ctx.state.sortDesc = ctx.state.filterState.sortDesc;
  ctx.state.isMovie = ctx.state.filterState.isMovie;
  ctx.state.lVote = ctx.state.filterState.lVote;
  ctx.state.rVote = ctx.state.filterState.rVote;
  _onLoadData(action, ctx);
}
