import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:movie/actions/apihelper.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:palette_generator/palette_generator.dart';
import 'action.dart';
import 'state.dart';

Effect<TVDetailPageState> buildEffect() {
  return combineEffects(<Object, Effect<TVDetailPageState>>{
    TVDetailPageAction.action: _onAction, 
    TVDetailPageAction.recommendationTapped:_onRecommendationTapped,
    Lifecycle.initState: _onInit,
  });
}

void _onAction(Action action, Context<TVDetailPageState> ctx) {
}
Future _onInit(Action action, Context<TVDetailPageState> ctx) async {
  try {
    var r = await ApiHelper.getTVDetail(ctx.state.tvid);
    if (r != null) {
      ctx.dispatch(TVDetailPageActionCreator.onInit(r));
      var paletteGenerator = await PaletteGenerator.fromImageProvider(
          NetworkImage(ImageUrl.getUrl(r.poster_path, ImageSize.w400)));
      ctx.dispatch(TVDetailPageActionCreator.onsetColor(paletteGenerator));
    }
    var q=await ApiHelper.getTVKeyWords(ctx.state.tvid);
    if (q!= null) ctx.dispatch(TVDetailPageActionCreator.onKeyWords(q));
    var credits = await ApiHelper.getTVCredits(ctx.state.tvid);
    if (credits != null)
      ctx.dispatch(TVDetailPageActionCreator.onCredits(credits));
    var l = await ApiHelper.getTVReviews(ctx.state.tvid);
    if (l != null) ctx.dispatch(TVDetailPageActionCreator.onSetReviews(l));
    var k = await ApiHelper.getTVImages(ctx.state.tvid);
    if (k != null) ctx.dispatch(TVDetailPageActionCreator.onSetImages(k));
    var f = await ApiHelper.getTVVideo(ctx.state.tvid);
    if (f != null) ctx.dispatch(TVDetailPageActionCreator.onSetVideos(f));
    var h=await ApiHelper.getRecommendationsTV(ctx.state.tvid);
    if (h != null) ctx.dispatch(TVDetailPageActionCreator.onSetRecommendations(h));
  } on Exception catch (e) {
    var r;
  }
}


  Future _onRecommendationTapped(Action action, Context<TVDetailPageState> ctx) async{
    await Navigator.of(ctx.context).pushNamed('TVDetailpage',arguments: {'movieid':action.payload});
  }
