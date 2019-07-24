import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/globalbasestate/state.dart';
import 'package:movie/models/videolist.dart';

class AccountPageState implements GlobalBaseState<AccountPageState> {

  String name;
  String avatar;
  bool islogin;
  int acountIdV3;
  String acountIdV4;
  AnimationController animationController;

  @override
  AccountPageState clone() {
    return AccountPageState()
    ..name=name
    ..avatar=avatar
    ..islogin=islogin
    ..animationController=animationController
    ..acountIdV3=acountIdV3
    ..acountIdV4=acountIdV4;
  }

  @override
  Color themeColor;
}

AccountPageState initState(Map<String, dynamic> args) {
  return AccountPageState()..name=''..islogin=true;
}
