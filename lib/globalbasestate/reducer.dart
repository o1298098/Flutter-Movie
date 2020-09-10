import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/app_user.dart';
import 'package:movie/models/base_api_model/user_premium_model.dart';

import 'action.dart';
import 'state.dart';

Reducer<GlobalState> buildReducer() {
  return asReducer(
    <Object, Reducer<GlobalState>>{
      GlobalAction.changeThemeColor: _onchangeThemeColor,
      GlobalAction.changeLocale: _onChangeLocale,
      GlobalAction.setUser: _onSetUser,
      GlobalAction.setUserPremium: _onSetUserPremium
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
  I18n.onLocaleChanged(l);
  return state.clone()..locale = l;
}

GlobalState _onSetUser(GlobalState state, Action action) {
  final AppUser user = action.payload;
  return state.clone()..user = user;
}

GlobalState _onSetUserPremium(GlobalState state, Action action) {
  final UserPremiumData _data = action.payload;
  final AppUser _user =
      AppUser(firebaseUser: state.user.firebaseUser, premium: _data);
  return state.clone()..user = _user;
}
