import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter/widgets.dart' hide Action;
import 'package:movie/actions/Adapt.dart';
import 'package:movie/actions/apihelper.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/customwidgets/custom_stfstate.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:palette_generator/palette_generator.dart';
import 'action.dart';
import 'state.dart';

Effect<TVDetailPageState> buildEffect() {
  return combineEffects(<Object, Effect<TVDetailPageState>>{
    TVDetailPageAction.action: _onAction,
    TVDetailPageAction.recommendationTapped: _onRecommendationTapped,
    TVDetailPageAction.castCellTapped: _onCastCellTapped,
    TVDetailPageAction.openMenu: _openMenu,
    TVDetailPageAction.showSnackBar: _showSnackBar,
    Lifecycle.initState: _onInit,
  });
}

void _onAction(Action action, Context<TVDetailPageState> ctx) {}

Future _onInit(Action action, Context<TVDetailPageState> ctx) async {
  try {
    final ticker=ctx.stfState as CustomstfState;
    ctx.state.animationController=AnimationController(vsync: ticker,duration: Duration(milliseconds: 1000));
    /*var paletteGenerator = await PaletteGenerator.fromImageProvider(
          CachedNetworkImageProvider(ImageUrl.getUrl(ctx.state.posterPic, ImageSize.w300)));
      ctx.dispatch(TVDetailPageActionCreator.onsetColor(paletteGenerator));*/
    var r = await ApiHelper.getTVDetail(ctx.state.tvid,
        appendtoresponse:
            'keywords,recommendations,credits,external_ids,content_ratings');
    if (r != null) {
      ctx.dispatch(TVDetailPageActionCreator.onInit(r));
      ctx.state.animationController.forward();
    }
    var accountstate = await ApiHelper.getTVAccountState(ctx.state.tvid);
    if (accountstate != null)
      ctx.dispatch(TVDetailPageActionCreator.onSetAccountState(accountstate));
    var l = await ApiHelper.getTVReviews(ctx.state.tvid);
    if (l != null) ctx.dispatch(TVDetailPageActionCreator.onSetReviews(l));

    var k = await ApiHelper.getTVImages(ctx.state.tvid);
    if (k != null) ctx.dispatch(TVDetailPageActionCreator.onSetImages(k));
    var f = await ApiHelper.getTVVideo(ctx.state.tvid);
    if (f != null) ctx.dispatch(TVDetailPageActionCreator.onSetVideos(f));
  } on Exception catch (e) {}
}

Future _onRecommendationTapped(
    Action action, Context<TVDetailPageState> ctx) async {
  await Navigator.of(ctx.context).pushNamed('tvdetailpage',
      arguments: {'tvid': action.payload[0], 'bgpic': action.payload[1]});
}

Future _onCastCellTapped(Action action, Context<TVDetailPageState> ctx) async {
  await Navigator.of(ctx.context).pushNamed('peopledetailpage', arguments: {
    'peopleid': action.payload[0],
    'profilePath': action.payload[1],
    'profileName': action.payload[2]
  });
}

void _openMenu(Action action, Context<TVDetailPageState> ctx) {
  showModalBottomSheet(
      context: ctx.context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return ctx.buildComponent('menu');
      });
}

void _showSnackBar(Action action, Context<TVDetailPageState> ctx) {
  ctx.state.scaffoldkey.currentState.showSnackBar(SnackBar(
    content: Text(action.payload ?? ''),
  ));
}
