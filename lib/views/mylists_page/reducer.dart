import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<MyListsPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<MyListsPageState>>{
      MyListsPageAction.action: _onAction,
    },
  );
}

MyListsPageState _onAction(MyListsPageState state, Action action) {
  final MyListsPageState newState = state.clone();
  return newState;
}
