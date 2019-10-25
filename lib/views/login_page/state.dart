import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:movie/globalbasestate/state.dart';

class LoginPageState implements GlobalBaseState, Cloneable<LoginPageState> {
  String account = '';
  String pwd = '';
  AnimationController animationController;
  AnimationController submitAnimationController;
  FocusNode accountFocusNode;
  FocusNode pwdFocusNode;

  @override
  LoginPageState clone() {
    return LoginPageState()
      ..account = account
      ..pwd = pwd
      ..accountFocusNode = accountFocusNode
      ..pwdFocusNode = pwdFocusNode
      ..animationController = animationController
      ..submitAnimationController = submitAnimationController;
  }

  @override
  Color themeColor;

  @override
  Locale locale;

  @override
  FirebaseUser user;
}

LoginPageState initState(Map<String, dynamic> args) {
  return LoginPageState();
}
