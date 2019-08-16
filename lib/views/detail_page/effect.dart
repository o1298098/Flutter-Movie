import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/actions/Adapt.dart';
import 'package:movie/actions/apihelper.dart';
import 'package:movie/customwidgets/custom_stfstate.dart';
import 'package:movie/customwidgets/gallery_photoview_wrapper.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'action.dart';
import 'state.dart';

Effect<MovieDetailPageState> buildEffect() {
  return combineEffects(<Object, Effect<MovieDetailPageState>>{
    MovieDetailPageAction.action: _onAction,
    MovieDetailPageAction.playTrailer: _playTrailer,
    MovieDetailPageAction.externalTapped: _onExternalTapped,
    MovieDetailPageAction.stillImageTapped: _stillImageTapped,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
  });
}

void _onAction(Action action, Context<MovieDetailPageState> ctx) {}

Future _onInit(Action action, Context<MovieDetailPageState> ctx) async {
  final ticker = ctx.stfState as CustomstfState;
  ctx.state.animationController = AnimationController(
      vsync: ticker, duration: Duration(milliseconds: 2000));
  ctx.state.scrollController = ScrollController();
  var r = await ApiHelper.getMovieDetail(ctx.state.mediaId,
      appendtoresponse:
          'keywords,recommendations,credits,external_ids,release_dates,images,videos');
  if (r != null) ctx.dispatch(MovieDetailPageActionCreator.updateDetail(r));
  var images = await ApiHelper.getMovieImages(ctx.state.mediaId);
  if (images != null)
    ctx.dispatch(MovieDetailPageActionCreator.onSetImages(images));
}

void _onDispose(Action action, Context<MovieDetailPageState> ctx) {
  ctx.state.animationController.dispose();
  ctx.state.scrollController.dispose();
}

Future _playTrailer(Action action, Context<MovieDetailPageState> ctx) async {
  var _model = ctx.state?.detail?.videos?.results ?? [];
  if (_model.length > 0)
    await showDialog(
        context: ctx.context,
        builder: (context) {
          return SimpleDialog(
            contentPadding: EdgeInsets.zero,
            children: <Widget>[
              YoutubePlayer(
                context: ctx.context,
                videoId: _model[0].key,
                flags: YoutubePlayerFlags(
                  mute: false,
                  autoPlay: true,
                  forceHideAnnotation: true,
                  showVideoProgressIndicator: true,
                ),
                videoProgressIndicatorColor: Colors.red,
                progressColors: ProgressColors(
                  playedColor: Colors.red,
                  handleColor: Colors.redAccent,
                ),
              ),
            ],
          );
        });
  else
    Toast.show('no video', ctx.context);
}

Future _onExternalTapped(
    Action action, Context<MovieDetailPageState> ctx) async {
  var url = action.payload;
  if (await canLaunch(url)) {
    await launch(url);
  }
}

Future _stillImageTapped(
    Action action, Context<MovieDetailPageState> ctx) async {
  await Navigator.of(ctx.context).push(PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return new FadeTransition(
            opacity: animation,
            child: GalleryPhotoViewWrapper(
              imageSize: ImageSize.w500,
              galleryItems: ctx.state.imagesmodel.backdrops,
              initialIndex: action.payload,
            ));
      }));
}
