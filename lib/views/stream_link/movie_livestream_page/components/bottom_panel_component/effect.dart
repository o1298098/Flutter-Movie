import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/actions/http/base_api.dart';
import 'package:movie/globalbasestate/store.dart';
import 'package:movie/models/models.dart';
import 'package:movie/widgets/stream_link_report_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'action.dart';
import 'state.dart';

Effect<BottomPanelState> buildEffect() {
  return combineEffects(<Object, Effect<BottomPanelState>>{
    BottomPanelAction.action: _onAction,
    Lifecycle.initState: _onInit,
    BottomPanelAction.useVideoSource: _useVideoSource,
    BottomPanelAction.streamInBrowser: _streamInBrowser,
    BottomPanelAction.commentTap: _commentTap,
    BottomPanelAction.likeMovie: _likeMovie,
    BottomPanelAction.reportStreamLink: _reportStreamLink,
    BottomPanelAction.requestStreamLink: _requestStreamLink,
    BottomPanelAction.showStreamlinkFilter: _showStreamlinkFilter,
    BottomPanelAction.downloadTap: _downloadTap,
  });
}

void _onAction(Action action, Context<BottomPanelState> ctx) {}

void _useVideoSource(Action action, Context<BottomPanelState> ctx) async {
  final bool _b = action.payload;
  final _pre = await SharedPreferences.getInstance();
  _pre.setBool('useVideoSourceApi', _b);
  ctx.dispatch(BottomPanelActionCreator.setUseVideoSource(_b));
}

void _streamInBrowser(Action action, Context<BottomPanelState> ctx) async {
  final bool _b = action.payload;
  final _pre = await SharedPreferences.getInstance();
  _pre.setBool('streamInBrowser', _b);
  ctx.dispatch(BottomPanelActionCreator.setStreamInBrowser(_b));
}

Future _commentTap(Action action, Context<BottomPanelState> ctx) async {
  await Navigator.of(ctx.context).push(
    PageRouteBuilder(
        barrierColor: const Color(0xAA000000),
        fullscreenDialog: true,
        barrierDismissible: true,
        opaque: false,
        pageBuilder: (context, animation, subAnimation) {
          return SlideTransition(
            position: Tween<Offset>(begin: Offset(0, 1), end: Offset(0, 0.3))
                .animate(
                    CurvedAnimation(parent: animation, curve: Curves.ease)),
            child: ctx.buildComponent('comments'),
          );
        }),
  );
}

void _onInit(Action action, Context<BottomPanelState> ctx) async {
  bool _useVideoSourceApi = true;
  bool _streamInBrowser = false;
  final _pre = await SharedPreferences.getInstance();
  if (_pre.containsKey('useVideoSourceApi'))
    _useVideoSourceApi = _pre.getBool('useVideoSourceApi');
  if (_pre.containsKey('streamInBrowser'))
    _streamInBrowser = _pre.getBool('streamInBrowser');
  ctx.dispatch(
      BottomPanelActionCreator.setOption(_useVideoSourceApi, _streamInBrowser));
}

Future _likeMovie(Action action, Context<BottomPanelState> ctx) async {
  final user = GlobalStore.store.getState().user;
  int _likeCount = ctx.state.likeCount;
  bool _userLike = ctx.state.userLiked;
  if (user?.firebaseUser == null) return;
  _userLike ? _likeCount-- : _likeCount++;
  ctx.dispatch(BottomPanelActionCreator.setLike(_likeCount, !_userLike));
  final _likeModel = MovieLikeModel.fromParams(
      movieId: ctx.state.movieId, id: 0, uid: user.firebaseUser.uid);

  final _result = _userLike
      ? await BaseApi.instance.unlikeMovie(_likeModel)
      : await BaseApi.instance.likeMovie(_likeModel);
  print(_result.result);
}

void _reportStreamLink(Action action, Context<BottomPanelState> ctx) {
  final _name = ctx.state.selectedLink?.linkName ?? 'video api';
  showDialog(
      context: ctx.context,
      builder: (_) {
        return StreamLinkReportDialog(
            report: StreamLinkReport(
          mediaId: ctx.state.movieId,
          mediaName: _name,
          linkName: _name,
          streamLink: ctx.state.selectedLink?.streamLink ?? '',
          type: "movie",
          streamLinkId: ctx.state.selectedLink?.sid ?? 0,
        ));
      });
}

void _requestStreamLink(Action action, Context<BottomPanelState> ctx) async {
  final _topic = 'movie_${ctx.state.movieId}';
  final _firebaseMessaging = FirebaseMessaging();
  final _token = await _firebaseMessaging.getToken();
  //_firebaseMessaging.subscribeToTopic(_topic);
  final _baseApi = BaseApi.instance;
  _baseApi.sendRequestStreamLink(StreamLinkReport()
    ..mediaId = ctx.state.movieId
    ..mediaName = ctx.state.movieName
    ..type = 'movie');
  _baseApi.subscribeTpoic(TopicSubscription.fromParams(
      topicId: _topic, cloudMessagingToken: _token));
  Toast.show(
      'You will be notified when the stream link has been added', ctx.context,
      duration: Toast.LENGTH_LONG);
}

void _showStreamlinkFilter(Action action, Context<BottomPanelState> ctx) async {
  await Navigator.of(ctx.context).push(
    PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        final _curvedAnimation =
            CurvedAnimation(parent: animation, curve: Curves.ease);
        return SlideTransition(
          position: Tween<Offset>(
            begin: Offset(0, 1),
            end: Offset.zero,
          ).animate(_curvedAnimation),
          child: FadeTransition(
              opacity: _curvedAnimation,
              child: ctx.buildComponent('streamLinkFilter')),
        );
      },
    ),
  );
}

void _downloadTap(Action action, Context<BottomPanelState> ctx) async {}
