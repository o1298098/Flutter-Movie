import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/animation.dart';
import 'package:movie/models/base_api_model/user_media.dart';

class WatchlistDetailPageState implements Cloneable<WatchlistDetailPageState> {
  UserMedia mediaData;
  AnimationController animationController;

  @override
  WatchlistDetailPageState clone() {
    return WatchlistDetailPageState()..mediaData = mediaData;
  }
}

WatchlistDetailPageState initState(Map<String, dynamic> args) {
  WatchlistDetailPageState state = WatchlistDetailPageState();
  state.mediaData = args['data'];
  return state;
}
