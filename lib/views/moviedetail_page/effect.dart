import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter/widgets.dart' hide Action;
import 'package:movie/actions/apihelper.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/enums/imagesize.dart';
//import 'package:palette_generator/palette_generator.dart';
import 'action.dart';
import 'state.dart';

Effect<MovieDetailPageState> buildEffect() {
  return combineEffects(<Object, Effect<MovieDetailPageState>>{
    MovieDetailPageAction.action: _onAction,
    MovieDetailPageAction.recommendationTapped:_onRecommendationTapped,
    MovieDetailPageAction.castCellTapped:_onCastCellTapped,
    Lifecycle.initState: _onInit,
  });
}

void _onAction(Action action, Context<MovieDetailPageState> ctx) {}

Future _onInit(Action action, Context<MovieDetailPageState> ctx) async {
  try {
    ctx.state.scrollController=new ScrollController();
    var r = await ApiHelper.getMovieDetail(ctx.state.movieid,appendtoresponse: 'keywords,recommendations,credits,external_ids,release_dates');
    if (r != null) {
      ctx.dispatch(MovieDetailPageActionCreator.onInit(r));
      /*var paletteGenerator = await PaletteGenerator.fromImageProvider(
         CachedNetworkImageProvider(ImageUrl.getUrl(r.poster_path, ImageSize.w400)));
      ctx.dispatch(MovieDetailPageActionCreator.onsetColor(paletteGenerator));*/
    }
    var l = await ApiHelper.getMovieReviews(ctx.state.movieid);
    if (l != null) ctx.dispatch(MovieDetailPageActionCreator.onSetReviews(l));
    var k = await ApiHelper.getMovieImages(ctx.state.movieid);
    if (k != null) ctx.dispatch(MovieDetailPageActionCreator.onSetImages(k));
    var f = await ApiHelper.getMovieVideo(ctx.state.movieid);
    if (f != null) ctx.dispatch(MovieDetailPageActionCreator.onSetVideos(f));
  } on Exception catch (e) {
    var r;
  }
}


  Future _onRecommendationTapped(Action action, Context<MovieDetailPageState> ctx) async{
    await Navigator.of(ctx.context).pushNamed('moviedetailpage',arguments: {'movieid':action.payload[0],'bgpic':action.payload[1]});
  }
  Future _onCastCellTapped(Action action, Context<MovieDetailPageState> ctx) async{
    await Navigator.of(ctx.context).pushNamed('peopledetailpage',arguments: {'peopleid':action.payload[0],'profilePath':action.payload[1],'profileName':action.payload[2]});
  }
