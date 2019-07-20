import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:movie/globalbasestate/state.dart';

class LoginPageState implements GlobalBaseState<LoginPageState> {
  
  
  String account='';
  String pwd='';
  AnimationController animationController;
  AnimationController submitAnimationController;
  FocusNode accountFocusNode;
  FocusNode pwdFocusNode;
 
  @override
  LoginPageState clone() {
    return  LoginPageState()
    ..account=account
    ..pwd=pwd
    ..accountFocusNode=accountFocusNode
    ..pwdFocusNode=pwdFocusNode
    ..animationController=animationController
    ..submitAnimationController=submitAnimationController;
  }

  @override
  Color themeColor;
}

LoginPageState initState(Map<String, dynamic> args) {

  return  LoginPageState();
}
