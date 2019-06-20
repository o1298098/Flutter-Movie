import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/apihelper.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:palette_generator/palette_generator.dart';
import 'action.dart';
import 'state.dart';

Effect<MovieDetailPageState> buildEffect() {
  return combineEffects(<Object, Effect<MovieDetailPageState>>{
    MovieDetailPageAction.action: _onAction,
    MovieDetailPageAction.recommendationTapped:_onRecommendationTapped,
    Lifecycle.initState: _onInit,
  });
}

void _onAction(Action action, Context<MovieDetailPageState> ctx) {}

Future _onInit(Action action, Context<MovieDetailPageState> ctx) async {
  try {
    var r = await ApiHelper.getMovieDetail(ctx.state.movieid);
    if (r != null) {
      ctx.dispatch(MovieDetailPageActionCreator.onInit(r));
      var paletteGenerator = await PaletteGenerator.fromImageProvider(
          NetworkImage(ImageUrl.getUrl(r.poster_path, ImageSize.w400)));
      ctx.dispatch(MovieDetailPageActionCreator.onsetColor(paletteGenerator));
    }
    var q=await ApiHelper.getMovieKeyWords(ctx.state.movieid);
    if (q!= null) ctx.dispatch(MovieDetailPageActionCreator.onKeyWords(q));
    var credits = await ApiHelper.getMovieCredits(ctx.state.movieid);
    if (credits != null)
      ctx.dispatch(MovieDetailPageActionCreator.onCredits(credits));
    var l = await ApiHelper.getMovieReviews(ctx.state.movieid);
    if (l != null) ctx.dispatch(MovieDetailPageActionCreator.onSetReviews(l));
    var k = await ApiHelper.getMovieImages(ctx.state.movieid);
    if (k != null) ctx.dispatch(MovieDetailPageActionCreator.onSetImages(k));
    var f = await ApiHelper.getMovieVideo(ctx.state.movieid);
    if (f != null) ctx.dispatch(MovieDetailPageActionCreator.onSetVideos(f));
    var h=await ApiHelper.getRecommendationsMovie(ctx.state.movieid);
    if (h != null) ctx.dispatch(MovieDetailPageActionCreator.onSetRecommendations(h));
  } on Exception catch (e) {
    var r;
  }
}


  Future _onRecommendationTapped(Action action, Context<MovieDetailPageState> ctx) async{
    await Navigator.of(ctx.context).pushNamed('moviedetailpage',arguments: {'movieid':action.payload});
  }
