import 'dart:ui';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:movie/globalbasestate/state.dart';
import 'package:movie/models/country_phone_code.dart';
import 'package:movie/models/app_user.dart';

class LoginPageState implements GlobalBaseState, Cloneable<LoginPageState> {
  String account = '';
  String pwd = '';
  bool emailLogin;
  TextEditingController accountTextController;
  TextEditingController passWordTextController;
  TextEditingController phoneTextController;
  TextEditingController codeTextContraller;
  AnimationController animationController;
  AnimationController submitAnimationController;
  FocusNode accountFocusNode;
  FocusNode pwdFocusNode;
  String countryCode;
  List<CountryPhoneCode> countryCodes;

  @override
  LoginPageState clone() {
    return LoginPageState()
      ..account = account
      ..pwd = pwd
      ..emailLogin = emailLogin
      ..accountFocusNode = accountFocusNode
      ..pwdFocusNode = pwdFocusNode
      ..animationController = animationController
      ..submitAnimationController = submitAnimationController
      ..accountTextController = accountTextController
      ..passWordTextController = passWordTextController
      ..phoneTextController = phoneTextController
      ..codeTextContraller = codeTextContraller
      ..countryCode = countryCode
      ..countryCodes = countryCodes;
  }

  @override
  Color themeColor;

  @override
  Locale locale;

  @override
  AppUser user;
}

LoginPageState initState(Map<String, dynamic> args) {
  return LoginPageState();
}
