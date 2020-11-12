import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/actions/api/tmdb_api.dart';
import 'package:movie/actions/api/base_api.dart';
import 'package:movie/widgets/gallery_photoview_wrapper.dart';
import 'package:movie/globalbasestate/store.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/enums/media_type.dart';
import 'package:movie/views/peopledetail_page/page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'action.dart';
import 'state.dart';

Effect<MovieDetailPageState> buildEffect() {
  return combineEffects(<Object, Effect<MovieDetailPageState>>{
    MovieDetailPageAction.action: _onAction,
    MovieDetailPageAction.playStreamLink: _playStreamLink,
    MovieDetailPageAction.externalTapped: _onExternalTapped,
    MovieDetailPageAction.stillImageTapped: _stillImageTapped,
    MovieDetailPageAction.movieCellTapped: _movieCellTapped,
    MovieDetailPageAction.castCellTapped: _castCellTapped,
    MovieDetailPageAction.openMenu: _openMenu,
    MovieDetailPageAction.showSnackBar: _showSnackBar,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
  });
}

void _onAction(Action action, Context<MovieDetailPageState> ctx) {}

Future _onInit(Action action, Context<MovieDetailPageState> ctx) async {
  final _id = ctx.state.mediaId;
  final Object ticker = ctx.stfState;
  ctx.state.animationController = AnimationController(
      vsync: ticker, duration: Duration(milliseconds: 2000));
  ctx.state.scrollController = ScrollController();
  final _baseApi = BaseApi.instance;
  Future.delayed(Duration(milliseconds: 300), () async {
    if (_id == null) return;
    final _tmdb = TMDBApi.instance;
    final r = await _tmdb.getMovieDetail(_id,
        appendtoresponse:
            'keywords,recommendations,credits,external_ids,release_dates,images,videos');
    if (r.success)
      ctx.dispatch(MovieDetailPageActionCreator.updateDetail(r.result));
    final _images = await _tmdb.getMovieImages(_id);
    if (_images.success)
      ctx.dispatch(MovieDetailPageActionCreator.onSetImages(_images.result));
    final _user = GlobalStore.store.getState().user;
    if (_user != null) {
      final _accountstate = await _baseApi.getAccountState(
          _user?.firebaseUser?.uid, ctx.state.mediaId, MediaType.movie);
      if (_accountstate.success)
        ctx.dispatch(MovieDetailPageActionCreator.onSetAccountState(
            _accountstate.result));
    }
  });
}

void _onDispose(Action action, Context<MovieDetailPageState> ctx) {
  ctx.state.animationController?.dispose();
  ctx.state.scrollController?.dispose();
}

Future _playStreamLink(Action action, Context<MovieDetailPageState> ctx) async {
  if (ctx.state.hasStreamLink)
    await Navigator.of(ctx.context).pushNamed('movieLiveStreamPage',
        arguments: {'detail': ctx.state.detail});
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

Future _movieCellTapped(
    Action action, Context<MovieDetailPageState> ctx) async {
  await Navigator.of(ctx.context).pushNamed('detailpage',
      arguments: {'id': action.payload[0], 'bgpic': action.payload[1]});
}

Future _castCellTapped(Action action, Context<MovieDetailPageState> ctx) async {
  await Navigator.of(ctx.context)
      .push(PageRouteBuilder(pageBuilder: (context, animation, secAnimation) {
    return FadeTransition(
      opacity: animation,
      child: PeopleDetailPage().buildPage({
        'peopleid': action.payload[0],
        'profilePath': action.payload[1],
        'profileName': action.payload[2],
        'character': action.payload[3]
      }),
    );
  }));
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
