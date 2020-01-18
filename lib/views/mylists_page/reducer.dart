import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/user_list.dart';

import 'action.dart';
import 'state.dart';

Reducer<MyListsPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<MyListsPageState>>{
      MyListsPageAction.action: _onAction,
      MyListsPageAction.setAccount: _setAccount,
      MyListsPageAction.setList: _setList,
      MyListsPageAction.onEdit: _onEdit,
    },
  );
}

MyListsPageState _onAction(MyListsPageState state, Action action) {
  final MyListsPageState newState = state.clone();
  return newState;
}

MyListsPageState _setAccount(MyListsPageState state, Action action) {
  String accountid = action.payload[0];
  final MyListsPageState newState = state.clone();
  newState.accountId = accountid;
  return newState;
}

MyListsPageState _setList(MyListsPageState state, Action action) {
  final UserListModel model = action.payload;
  final MyListsPageState newState = state.clone();
  newState.listData = model;
  return newState;
}

MyListsPageState _onEdit(MyListsPageState state, Action action) {
  final bool isEdit = action.payload;
  final MyListsPageState newState = state.clone();
  newState.isEdit = isEdit;
  return newState;
}
