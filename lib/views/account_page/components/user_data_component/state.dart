import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/app_user.dart';
import 'package:movie/models/base_api_model/account_info.dart';
import 'package:movie/views/account_page/state.dart';

class UserDataState implements Cloneable<UserDataState> {
  AppUser user;
  AccountInfo info;
  @override
  UserDataState clone() {
    return UserDataState()
      ..user = user
      ..info = info;
  }
}

class UserDataConnector extends ConnOp<AccountState, UserDataState> {
  @override
  UserDataState get(AccountState state) {
    UserDataState substate = state.userDataState.clone();
    substate.user = state.user;
    return substate;
  }

  @override
  void set(AccountState state, UserDataState subState) {
    state.userDataState = subState;
  }
}
