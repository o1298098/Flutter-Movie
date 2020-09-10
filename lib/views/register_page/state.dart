import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

class RegisterPageState implements Cloneable<RegisterPageState> {
  String emailAddress;
  String password;
  String name;
  TextEditingController nameTextController;
  TextEditingController passWordTextController;
  TextEditingController emailTextController;
  FocusNode nameFocusNode;
  FocusNode emailFocusNode;
  FocusNode pwdFocusNode;
  AnimationController submitAnimationController;

  @override
  RegisterPageState clone() {
    return RegisterPageState()
      ..emailAddress = emailAddress
      ..password = password
      ..name = name
      ..nameFocusNode = nameFocusNode
      ..emailFocusNode = emailFocusNode
      ..pwdFocusNode = pwdFocusNode
      ..submitAnimationController = submitAnimationController
      ..emailTextController = emailTextController
      ..passWordTextController = passWordTextController
      ..nameTextController = nameTextController;
  }
}

RegisterPageState initState(Map<String, dynamic> args) {
  return RegisterPageState();
}
