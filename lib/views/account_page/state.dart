import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:movie/globalbasestate/state.dart';

class AccountPageState implements GlobalBaseState<AccountPageState> {

  @override
  AccountPageState clone() {
    return AccountPageState();
  }

  @override
  Color themeColor;
}

AccountPageState initState(Map<String, dynamic> args) {
  return AccountPageState();
}
