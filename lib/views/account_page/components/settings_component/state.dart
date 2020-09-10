import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/item.dart';
import 'package:movie/views/account_page/state.dart';

class SettingsState implements Cloneable<SettingsState> {
  bool adultContent;
  bool enableNotifications;
  Item appLanguage;
  String version;
  @override
  SettingsState clone() {
    return SettingsState()
      ..adultContent = adultContent
      ..enableNotifications = enableNotifications
      ..appLanguage = appLanguage
      ..version = version;
  }
}

class SettingsConnector extends ConnOp<AccountState, SettingsState> {
  @override
  SettingsState get(AccountState state) {
    SettingsState substate = state.settingsState;
    return substate;
  }

  @override
  void set(AccountState state, SettingsState subState) {
    state.settingsState = subState;
  }
}
