import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/actions/apihelper.dart';
import 'package:movie/actions/base_api.dart';
import 'package:movie/customwidgets/custom_stfstate.dart';
import 'package:movie/customwidgets/gallery_photoview_wrapper.dart';
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
  final ticker = ctx.stfState as CustomstfState;
  ctx.state.animationController = AnimationController(
      vsync: ticker, duration: Duration(milliseconds: 2000));
  ctx.state.scrollController = ScrollController();
  Future.delayed(Duration(milliseconds: 300), () async {
    BaseApi.hasMovieStreamLinks(ctx.state.mediaId).then((d) {
      ctx.dispatch(MovieDetailPageActionCreator.setHasStreamLink(d));
    });
    if (_id == null) return;
    var r = await ApiHelper.getMovieDetail(_id,
        appendtoresponse:
            'keywords,recommendations,credits,external_ids,release_dates,images,videos');
    if (r != null) ctx.dispatch(MovieDetailPageActionCreator.updateDetail(r));
    var images = await ApiHelper.getMovieImages(_id);
    if (images != null)
      ctx.dispatch(MovieDetailPageActionCreator.onSetImages(images));
    final _user = GlobalStore.store.getState().user;
    if (_user != null) {
      var accountstate = await BaseApi.getAccountState(
          _user.firebaseUser.uid, ctx.state.mediaId, MediaType.movie);
      if (accountstate != null)
        ctx.dispatch(
            MovieDetailPageActionCreator.onSetAccountState(accountstate));
    }
  });
}

void _onDispose(Action action, Context<MovieDetailPageState> ctx) {
  ctx.state.animationController?.dispose();
  ctx.state.scrollController?.dispose();
}

Future _playStreamLink(Action action, Context<MovieDetailPageState> ctx) async {
  if (ctx.state.hasStreamLink)
    await Navigator.of(ctx.context).pushNamed('liveStreamPage', arguments: {
      'id': ctx.state.mediaId,
      'name': ctx.state.detail.title,
      'rated': ctx.state.detail.voteAverage,
      'rateCount': ctx.state.detail.voteCount,
      'releaseDate': ctx.state.detail.releaseDate
    });
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
  ctx.state.scaffoldkey.currentState.showSnackBar(SnackBar(
    content: Text(action.payload ?? ''),
  ));
}
