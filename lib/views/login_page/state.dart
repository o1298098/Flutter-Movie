import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:movie/globalbasestate/state.dart';

class LoginPageState implements GlobalBaseState<LoginPageState> {
  
  
  String account='';
  String pwd='';
 
  @override
  LoginPageState clone() {
    return  LoginPageState()
    ..account=account
    ..pwd=pwd;
  }

  @override
  Color themeColor;
}

LoginPageState initState(Map<String, dynamic> args) {

  return  LoginPageState();
}
