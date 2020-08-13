import 'package:fish_redux/fish_redux.dart';
import 'package:movie/views/account_test/state.dart';

class SettingsState implements Cloneable<SettingsState> {
  @override
  SettingsState clone() {
    return SettingsState();
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
