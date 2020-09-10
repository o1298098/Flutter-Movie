import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/base_api_model/user_media.dart';
import 'package:movie/views/favorites_page/state.dart';

class HeaderState implements Cloneable<HeaderState> {
  UserMedia selectedMedia;
  AnimationController animationController;
  @override
  HeaderState clone() {
    return HeaderState()
      ..selectedMedia = selectedMedia
      ..animationController = animationController;
  }
}

class HeaderConnector extends ConnOp<FavoritesPageState, HeaderState> {
  @override
  HeaderState get(FavoritesPageState state) {
    final HeaderState mstate = HeaderState();
    mstate.animationController = state.animationController;
    mstate.selectedMedia = state.selectedMedia;
    return mstate;
  }
}
