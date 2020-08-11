import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:movie/globalbasestate/state.dart';
import 'package:movie/models/app_user.dart';

class AccountState implements GlobalBaseState, Cloneable<AccountState> {
  String name;
  String avatar;
  int selectedTabBarIndex;
  bool showTip;
  bool islogin;
  @override
  AccountState clone() {
    return AccountState()
      ..islogin = islogin
      ..avatar = avatar
      ..selectedTabBarIndex = selectedTabBarIndex
      ..showTip = showTip
      ..user = user;
  }

  @override
  Locale locale;

  @override
  Color themeColor;

  @override
  AppUser user;
}

AccountState initState(Map<String, dynamic> args) {
  AccountState state = AccountState();
  state.selectedTabBarIndex = 0;
  state.showTip = true;
  return state;
}
