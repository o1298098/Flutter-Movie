import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;

import 'action.dart';
import 'state.dart';

Reducer<GlobalState> buildReducer() {
  return asReducer(
    <Object, Reducer<GlobalState>>{
      GlobalAction.changeThemeColor: _onchangeThemeColor,
      GlobalAction.changeLocale: _onChangeLocale,
      GlobalAction.setUser: _onSetUser,
    },
  );
}

List<Color> _colors = <Color>[
  Colors.green,
  Colors.red,
  Colors.black,
  Colors.blue
];

GlobalState _onchangeThemeColor(GlobalState state, Action action) {
  final Color next =
      _colors[((_colors.indexOf(state.themeColor) + 1) % _colors.length)];
  return state.clone()..themeColor = next;
}

GlobalState _onChangeLocale(GlobalState state, Action action) {
  final Locale l = action.payload;
  return state.clone()..locale = l;
}

GlobalState _onSetUser(GlobalState state, Action action) {
  final FirebaseUser user = action.payload;
  return state.clone()..user = user;
}
