import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/globalbasestate/state.dart';
import 'package:movie/models/app_user.dart';
import 'package:movie/models/item.dart';
import 'package:movie/widgets/overlay_entry_manage.dart';

import 'components/data_panel_component/state.dart';
import 'components/settings_component/state.dart';
import 'components/user_data_component/state.dart';
import 'components/user_info_component/state.dart';

class AccountState implements GlobalBaseState, Cloneable<AccountState> {
  String name;
  String avatar;
  int selectedTabBarIndex;
  bool showTip;
  String tip;
  UserInfoState userInfoState;
  SettingsState settingsState;
  UserDataState userDataState;
  DataPanelState dataPanelState;
  @override
  AccountState clone() {
    return AccountState()
      ..avatar = avatar
      ..selectedTabBarIndex = selectedTabBarIndex
      ..showTip = showTip
      ..tip = tip
      ..user = user
      ..userInfoState = userInfoState
      ..settingsState = settingsState
      ..userDataState = userDataState
      ..dataPanelState = dataPanelState;
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
  state.userInfoState = UserInfoState()
    ..overlayStateKey = GlobalKey<OverlayEntryManageState>();
  state.userDataState = UserDataState();
  state.dataPanelState = DataPanelState();
  state.settingsState = SettingsState()
    ..appLanguage = Item.fromParams(name: "System Default")
    ..adultContent = false
    ..enableNotifications = true;
  return state;
}
