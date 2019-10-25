import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_redux/fish_redux.dart';

enum GlobalAction { changeThemeColor, changeLocale, setUser }

class GlobalActionCreator {
  static Action onchangeThemeColor() {
    return const Action(GlobalAction.changeThemeColor);
  }

  static Action changeLocale(Locale l) {
    return Action(GlobalAction.changeLocale, payload: l);
  }

  static Action setUser(FirebaseUser user) {
    return Action(GlobalAction.setUser, payload: user);
  }
}
