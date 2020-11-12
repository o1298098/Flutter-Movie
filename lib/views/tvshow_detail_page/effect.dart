import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/actions/api/tmdb_api.dart';
import 'package:movie/actions/api/base_api.dart';
import 'package:movie/widgets/gallery_photoview_wrapper.dart';
import 'package:movie/globalbasestate/store.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/enums/media_type.dart';
import 'package:movie/models/image_model.dart';
import 'action.dart';
import 'state.dart';

Effect<TvShowDetailState> buildEffect() {
  return combineEffects(<Object, Effect<TvShowDetailState>>{
    TvShowDetailAction.action: _onAction,
    TvShowDetailAction.recommendationTapped: _onRecommendationTapped,
    TvShowDetailAction.castCellTapped: _onCastCellTapped,
    TvShowDetailAction.openMenu: _openMenu,
    TvShowDetailAction.showSnackBar: _showSnackBar,
    TvShowDetailAction.onImageCellTapped: _onImageCellTapped,
    TvShowDetailAction.moreEpisode: _moreEpisode,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
  });
}

void _onAction(Action action, Context<TvShowDetailState> ctx) {}

Future _onInit(Action action, Context<TvShowDetailState> ctx) async {
  try {
    Future.delayed(Duration(milliseconds: 300), () async {
      final _tmdb = TMDBApi.instance;
      final _tvDetail = await _tmdb.getTVDetail(ctx.state.tvid,
          appendtoresponse:
              'keywords,recommendations,credits,external_ids,content_ratings');
      if (_tvDetail.success) {
        ctx.dispatch(TvShowDetailActionCreator.onInit(_tvDetail.result));
      }

      final _tvVideo = await _tmdb.getTVVideo(ctx.state.tvid);
      if (_tvVideo.success)
        ctx.dispatch(TvShowDetailActionCreator.onSetVideos(_tvVideo.result));
      final _tvImages = await _tmdb.getTVImages(ctx.state.tvid);
      if (_tvImages.success)
        ctx.dispatch(TvShowDetailActionCreator.onSetImages(_tvImages.result));

      final _user = GlobalStore.store.getState().user;
      if (_user != null) {
        final _baseApi = BaseApi.instance;
        final _accountstate = await _baseApi.getAccountState(
            _user?.firebaseUser?.uid, ctx.state.tvid, MediaType.tv);
        if (_accountstate.success)
          ctx.dispatch(TvShowDetailActionCreator.onSetAccountState(
              _accountstate.result));
      }
    });
  } on Exception catch (_) {}
}

void _onDispose(Action action, Context<TvShowDetailState> ctx) {}

void _moreEpisode(Action action, Context<TvShowDetailState> ctx) async {
  if (ctx.state.tvDetailModel != null)
    await Navigator.of(ctx.context).pushNamed('seasonLinkPage', arguments: {
      'tvid': ctx.state.tvid,
      'detail': ctx.state.tvDetailModel,
    });
}

Future _onRecommendationTapped(
    Action action, Context<TvShowDetailState> ctx) async {
  await Navigator.of(ctx.context).pushNamed('tvShowdetailpage',
      arguments: {'id': action.payload[0], 'bgpic': action.payload[1]});
}

Future _onCastCellTapped(Action action, Context<TvShowDetailState> ctx) async {
  await Navigator.of(ctx.context).pushNamed('peopledetailpage', arguments: {
    'peopleid': action.payload[0],
    'profilePath': action.payload[1],
    'profileName': action.payload[2]
  });
}

void _openMenu(Action action, Context<TvShowDetailState> ctx) {
  showModalBottomSheet(
      context: ctx.context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return ctx.buildComponent('menu');
      });
}

void _showSnackBar(Action action, Context<TvShowDetailState> ctx) {
  ScaffoldMessenger.of(ctx.context).showSnackBar(SnackBar(
    content: Text(action.payload ?? ''),
  ));
}

Future _onImageCellTapped(Action action, Context<TvShowDetailState> ctx) async {
  final int _index = action.payload[0];
  final List<ImageData> _images = action.payload[1];
  await Navigator.of(ctx.context).push(
    PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return new FadeTransition(
          opacity: animation,
          child: GalleryPhotoViewWrapper(
            imageSize: ImageSize.w400,
            galleryItems: _images,
            initialIndex: _index,
          ),
        );
      },
    ),
  );
}
