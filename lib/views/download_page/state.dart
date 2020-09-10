import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

class DownloadPageState implements Cloneable<DownloadPageState> {
  List<DownloadTask> downloadTask;
  AnimationController animationController;
  String name;
  String streamAddress;
  String posterUrl;
  @override
  DownloadPageState clone() {
    return DownloadPageState()
      ..downloadTask = downloadTask
      ..animationController = animationController
      ..name = name
      ..posterUrl = posterUrl
      ..streamAddress = streamAddress;
  }
}

DownloadPageState initState(Map<String, dynamic> args) {
  DownloadPageState state = DownloadPageState();
  if (args != null) {
    if (args.containsKey('name')) state.name = args['name'];
    if (args.containsKey('streamAddress'))
      state.streamAddress = args['streamAddress'];
    if (args.containsKey('posterUrl')) state.posterUrl = args['posterUrl'];
  }
  return state;
}
