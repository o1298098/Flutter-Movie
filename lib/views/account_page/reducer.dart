import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/videolist.dart';

import 'action.dart';
import 'state.dart';

Reducer<AccountPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<AccountPageState>>{
      AccountPageAction.action: _onAction,
      AccountPageAction.init:_onInit,
    },
  );
}

AccountPageState _onAction(AccountPageState state, Action action) {
  final AccountPageState newState = state.clone();
  return newState;
}
AccountPageState _onInit(AccountPageState state, Action action) {
  final String name=action.payload[0]??'Guest';
  final String avatar=action.payload[1]??'https://www.gravatar.com/avatar/';
  final bool islogin=action.payload[2]??false;
  final int accountIdV3=action.payload[3];
  final String accountIdV4=action.payload[4];
  final AccountPageState newState = state.clone();
  newState.name=name;
  newState.avatar=avatar;
  newState.islogin=islogin;
  newState.acountIdV3=accountIdV3;
  newState.acountIdV4=accountIdV4;
  return newState;
}
