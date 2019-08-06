import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter/widgets.dart' hide Action;
import 'package:movie/actions/apihelper.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/customwidgets/custom_stfstate.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:palette_generator/palette_generator.dart';
import 'action.dart';
import 'state.dart';

Effect<MovieDetailPageState> buildEffect() {
  return combineEffects(<Object, Effect<MovieDetailPageState>>{
    MovieDetailPageAction.action: _onAction,
    MovieDetailPageAction.recommendationTapped:_onRecommendationTapped,
    MovieDetailPageAction.castCellTapped:_onCastCellTapped,
    MovieDetailPageAction.openMenu: _openMenu,
    MovieDetailPageAction.showSnackBar: _showSnackBar,
    Lifecycle.initState: _onInit,
  });
}

void _onAction(Action action, Context<MovieDetailPageState> ctx) {}

Future _onInit(Action action, Context<MovieDetailPageState> ctx) async {
  try { 
    final ticker=ctx.stfState as CustomstfState;
    ctx.state.animationController=AnimationController(vsync: ticker,duration: Duration(milliseconds: 1000));
    ctx.state.scrollController=new ScrollController();
     /*var paletteGenerator = await PaletteGenerator.fromImageProvider(
         CachedNetworkImageProvider(ImageUrl.getUrl(ctx.state.posterPic, ImageSize.w300)));
      ctx.dispatch(MovieDetailPageActionCreator.onsetColor(paletteGenerator));*/
    var r = await ApiHelper.getMovieDetail(ctx.state.movieid,appendtoresponse: 'keywords,recommendations,credits,external_ids,release_dates');
    if (r != null) {
      ctx.dispatch(MovieDetailPageActionCreator.onInit(r));
      ctx.state.animationController.forward();
    } 
    var accountstate = await ApiHelper.getMovieAccountState(ctx.state.movieid);
    if (accountstate != null)
      ctx.dispatch(MovieDetailPageActionCreator.onSetAccountState(accountstate));
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
  void _openMenu(Action action, Context<MovieDetailPageState> ctx) {
  showModalBottomSheet(
      context: ctx.context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return ctx.buildComponent('menu');
      });
}

void _showSnackBar(Action action, Context<MovieDetailPageState> ctx) {
  ctx.state.scaffoldkey.currentState.showSnackBar(SnackBar(content: Text(action.payload??''),));
}
