import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/globalbasestate/store.dart';

class SettingPageState implements Cloneable<SettingPageState> {
  AnimationController pageAnimation;
  FirebaseUser user;
  @override
  SettingPageState clone() {
    return SettingPageState()
      ..pageAnimation = pageAnimation
      ..user = user;
  }
}

SettingPageState initState(Map<String, dynamic> args) {
  return SettingPageState()..user = GlobalStore.store.getState().user;
}
