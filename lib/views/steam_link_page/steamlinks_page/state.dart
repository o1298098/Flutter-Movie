import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:movie/globalbasestate/state.dart';
import 'package:video_player/video_player.dart';

class StreamLinksPageState
    implements GlobalBaseState, Cloneable<StreamLinksPageState> {
  Stream<QuerySnapshot> snapshot;
  VideoPlayerController controller;
  @override
  StreamLinksPageState clone() {
    return StreamLinksPageState()
      ..user = user
      ..snapshot = snapshot
      ..controller = controller;
  }

  @override
  Locale locale;

  @override
  Color themeColor;

  @override
  FirebaseUser user;
}

StreamLinksPageState initState(Map<String, dynamic> args) {
  return StreamLinksPageState();
}
