import 'dart:ui';

import 'package:chewie/chewie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/globalbasestate/state.dart';
import 'package:movie/models/enums/streamlink_type.dart';
import 'package:movie/models/firebase/firebase_streamlink.dart';
import 'package:video_player/video_player.dart';

class LiveStreamPageState
    implements GlobalBaseState, Cloneable<LiveStreamPageState> {
  String id;
  String name;
  double rated;
  int rateCount;
  String releaseDate;
  String comment;
  String youtubeID;
  FocusNode commentFocusNode;
  TextEditingController commentController;
  List<VideoPlayerController> videoControllers;
  ChewieController chewieController;
  List<StreamLinkModel> streamLinks;
  StreamLinkType streamLinkType;

  @override
  LiveStreamPageState clone() {
    return LiveStreamPageState()
      ..id = id
      ..name = name
      ..rated = rated
      ..rateCount = rateCount
      ..releaseDate = releaseDate
      ..user = user
      ..streamLinks = streamLinks
      ..comment = comment
      ..youtubeID = youtubeID
      ..streamLinkType = streamLinkType
      ..commentController = commentController
      ..commentFocusNode = commentFocusNode
      ..videoControllers = videoControllers
      ..chewieController = chewieController;
  }

  @override
  Locale locale;

  @override
  Color themeColor;

  @override
  FirebaseUser user;
}

LiveStreamPageState initState(Map<String, dynamic> args) {
  return LiveStreamPageState()
    ..id = args['id']
    ..name = args['name']
    ..rateCount = args['rateCount']
    ..rated = args['rated']
    ..releaseDate = args['releaseDate'];
}
