import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<CreateListPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<CreateListPageState>>{
      CreateListPageAction.action: _onAction,
    },
  );
}

CreateListPageState _onAction(CreateListPageState state, Action action) {
  final CreateListPageState newState = state.clone();
  return newState;
}
