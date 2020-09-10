import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter/widgets.dart' hide Action;
import 'package:movie/actions/http/tmdb_api.dart';
import 'package:movie/actions/http/base_api.dart';
import 'package:movie/widgets/gallery_photoview_wrapper.dart';
import 'package:movie/globalbasestate/store.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/enums/media_type.dart';
import 'package:movie/models/image_model.dart';
import 'action.dart';
import 'state.dart';

Effect<TVDetailPageState> buildEffect() {
  return combineEffects(<Object, Effect<TVDetailPageState>>{
    TVDetailPageAction.action: _onAction,
    TVDetailPageAction.recommendationTapped: _onRecommendationTapped,
    TVDetailPageAction.castCellTapped: _onCastCellTapped,
    TVDetailPageAction.openMenu: _openMenu,
    TVDetailPageAction.showSnackBar: _showSnackBar,
    TVDetailPageAction.onImageCellTapped: _onImageCellTapped,
    TVDetailPageAction.plyaTapped: _onPlayTapped,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
  });
}

void _onAction(Action action, Context<TVDetailPageState> ctx) {}

Future _onInit(Action action, Context<TVDetailPageState> ctx) async {
  try {
    final Object ticker = ctx.stfState;
    ctx.state.animationController = AnimationController(
        vsync: ticker, duration: Duration(milliseconds: 1000));

    Future.delayed(Duration(milliseconds: 300), () async {
      final _tmdb = TMDBApi.instance;
      final _detail = await _tmdb.getTVDetail(ctx.state.tvid,
          appendtoresponse:
              'keywords,recommendations,credits,external_ids,content_ratings');
      if (_detail.success) {
        ctx.dispatch(TVDetailPageActionCreator.onInit(_detail.result));
        ctx.state.animationController.forward();
      }
      final _tvReviews = await _tmdb.getTVReviews(ctx.state.tvid);
      if (_tvReviews.success)
        ctx.dispatch(TVDetailPageActionCreator.onSetReviews(_tvReviews.result));

      final _tvImages = await _tmdb.getTVImages(ctx.state.tvid);
      if (_tvImages.success)
        ctx.dispatch(TVDetailPageActionCreator.onSetImages(_tvImages.result));
      final _tvVideo = await _tmdb.getTVVideo(ctx.state.tvid);
      if (_tvVideo.success)
        ctx.dispatch(TVDetailPageActionCreator.onSetVideos(_tvVideo.result));

      final _user = GlobalStore.store.getState().user;
      if (_user != null) {
        final _baseApi = BaseApi.instance;
        final _accountstate = await _baseApi.getAccountState(
            _user.firebaseUser.uid, ctx.state.tvid, MediaType.tv);
        if (_accountstate.success)
          ctx.dispatch(TVDetailPageActionCreator.onSetAccountState(
              _accountstate.result));
      }
    });
  } on Exception catch (_) {}
}

void _onDispose(Action action, Context<TVDetailPageState> ctx) {
  ctx.state.animationController?.dispose();
}

void _onPlayTapped(Action action, Context<TVDetailPageState> ctx) async {
  if (ctx.state.tvDetailModel != null)
    await Navigator.of(ctx.context).pushNamed('seasonLinkPage', arguments: {
      'tvid': ctx.state.tvid,
      'detail': ctx.state.tvDetailModel,
    });
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

Future _onImageCellTapped(Action action, Context<TVDetailPageState> ctx) async {
  final int _index = action.payload[0];
  final List<ImageData> _images = action.payload[1];
  await Navigator.of(ctx.context).push(PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return new FadeTransition(
            opacity: animation,
            child: GalleryPhotoViewWrapper(
              imageSize: ImageSize.w400,
              galleryItems: _images,
              initialIndex: _index,
            ));
      }));
}
