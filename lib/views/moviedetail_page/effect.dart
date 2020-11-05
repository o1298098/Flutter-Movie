import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter/widgets.dart' hide Action;
import 'package:movie/actions/api/tmdb_api.dart';
import 'action.dart';
import 'state.dart';

Effect<MovieDetailPageState> buildEffect() {
  return combineEffects(<Object, Effect<MovieDetailPageState>>{
    MovieDetailPageAction.action: _onAction,
    MovieDetailPageAction.recommendationTapped: _onRecommendationTapped,
    MovieDetailPageAction.castCellTapped: _onCastCellTapped,
    MovieDetailPageAction.openMenu: _openMenu,
    MovieDetailPageAction.showSnackBar: _showSnackBar,
    Lifecycle.initState: _onInit,
  });
}

void _onAction(Action action, Context<MovieDetailPageState> ctx) {}

Future _onInit(Action action, Context<MovieDetailPageState> ctx) async {
  try {
    final Object ticker = ctx.stfState;
    ctx.state.animationController = AnimationController(
        vsync: ticker, duration: Duration(milliseconds: 1000));
    ctx.state.scrollController = new ScrollController();
    /*var paletteGenerator = await PaletteGenerator.fromImageProvider(
         CachedNetworkImageProvider(ImageUrl.getUrl(ctx.state.posterPic, ImageSize.w300)));
      ctx.dispatch(MovieDetailPageActionCreator.onsetColor(paletteGenerator));*/
    final _tmdb = TMDBApi.instance;
    final r = await _tmdb.getMovieDetail(ctx.state.movieid,
        appendtoresponse:
            'keywords,recommendations,credits,external_ids,release_dates');
    if (r.success) {
      ctx.dispatch(MovieDetailPageActionCreator.onInit(r.result));
      ctx.state.animationController.forward();
    }
    final accountstate = await _tmdb.getMovieAccountState(ctx.state.movieid);
    if (accountstate.success)
      ctx.dispatch(
          MovieDetailPageActionCreator.onSetAccountState(accountstate.result));
    final l = await _tmdb.getMovieReviews(ctx.state.movieid);
    if (l.success)
      ctx.dispatch(MovieDetailPageActionCreator.onSetReviews(l.result));
    final k = await _tmdb.getMovieImages(ctx.state.movieid);
    if (k.success)
      ctx.dispatch(MovieDetailPageActionCreator.onSetImages(k.result));
    final f = await _tmdb.getMovieVideo(ctx.state.movieid);
    if (f.success)
      ctx.dispatch(MovieDetailPageActionCreator.onSetVideos(f.result));
  } on Exception catch (_) {}
}

Future _onRecommendationTapped(
    Action action, Context<MovieDetailPageState> ctx) async {
  await Navigator.of(ctx.context).pushNamed('moviedetailpage',
      arguments: {'movieid': action.payload[0], 'bgpic': action.payload[1]});
}

Future _onCastCellTapped(
    Action action, Context<MovieDetailPageState> ctx) async {
  await Navigator.of(ctx.context).pushNamed('peopledetailpage', arguments: {
    'peopleid': action.payload[0],
    'profilePath': action.payload[1],
    'profileName': action.payload[2]
  });
}

void _openMenu(Action action, Context<MovieDetailPageState> ctx) {
  showModalBottomSheet(
      context: ctx.context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return ctx.buildComponent('menu');
      });
}

void _showSnackBar(Action action, Context<MovieDetailPageState> ctx) {
  ScaffoldMessenger.of(ctx.context).showSnackBar(SnackBar(
    content: Text(action.payload ?? ''),
  ));
}
