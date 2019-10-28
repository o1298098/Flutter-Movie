import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:video_player/video_player.dart';
import 'action.dart';
import 'state.dart';

Effect<StreamLinksPageState> buildEffect() {
  return combineEffects(<Object, Effect<StreamLinksPageState>>{
    StreamLinksPageAction.action: _onAction,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
  });
}

void _onAction(Action action, Context<StreamLinksPageState> ctx) {}

void _onInit(Action action, Context<StreamLinksPageState> ctx) {
  ctx.state.controller = VideoPlayerController.network(
      'https://prxxx002.meomeo.pw/457201r000i87MLwDc/titanic.1997.720p.hdtv.x264-yify.m3u8')
    ..initialize()
    ..play();
  if (ctx.state.user != null) {
    final Stream<QuerySnapshot> snapshot = Firestore.instance
        .collection('AccountState')
        .document(ctx.state.user.uid)
        .collection('MyStreamLink')
        .snapshots();
    ctx.dispatch(StreamLinksPageActionCreator.setSnapshot(snapshot));
  }
}

void _onDispose(Action action, Context<StreamLinksPageState> ctx) {
  ctx.state.controller.dispose();
}
