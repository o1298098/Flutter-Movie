import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/app_user.dart';
import 'package:movie/views/account_page/state.dart';
import 'package:movie/widgets/overlay_entry_manage.dart';

class UserInfoState implements Cloneable<UserInfoState> {
  AppUser user;
  GlobalKey<OverlayEntryManageState> overlayStateKey;
  @override
  UserInfoState clone() {
    return UserInfoState()
      ..user = user
      ..overlayStateKey = overlayStateKey;
  }
}

class UserInfoConnector extends ConnOp<AccountState, UserInfoState> {
  @override
  UserInfoState get(AccountState state) {
    UserInfoState substate = state.userInfoState.clone();
    substate.user = state.user;
    return substate;
  }
}
