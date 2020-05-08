import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/globalbasestate/state.dart';
import 'package:movie/models/app_user.dart';

class AccountPageState implements GlobalBaseState, Cloneable<AccountPageState> {
  GlobalKey<ScaffoldState> scafoldState =
      GlobalKey<ScaffoldState>(debugLabel: 'accountPageScafold');
  String name;
  String avatar;
  bool islogin;
  int acountIdV3;
  String acountIdV4;
  AnimationController animationController;
  int themeIndex;
  @override
  AccountPageState clone() {
    return AccountPageState()
      ..name = name
      ..avatar = avatar
      ..islogin = islogin
      ..animationController = animationController
      ..acountIdV3 = acountIdV3
      ..acountIdV4 = acountIdV4
      ..themeIndex = themeIndex
      ..locale = locale
      ..themeColor = themeColor
      ..scafoldState = scafoldState
      ..user = user;
  }

  @override
  Locale locale;

  @override
  Color themeColor;

  @override
  AppUser user;
}

AccountPageState initState(Map<String, dynamic> args) {
  return AccountPageState()
    ..name = ''
    ..islogin = false
    ..themeIndex = 2;
}
