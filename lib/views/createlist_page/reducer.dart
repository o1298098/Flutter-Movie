import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<CreateListPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<CreateListPageState>>{
      CreateListPageAction.action: _onAction,
      CreateListPageAction.setName: _setName,
      CreateListPageAction.setBackGround: _setBackGround,
      CreateListPageAction.setDescription: _setDescription,
    },
  );
}

CreateListPageState _onAction(CreateListPageState state, Action action) {
  final CreateListPageState newState = state.clone();
  return newState;
}

CreateListPageState _setName(CreateListPageState state, Action action) {
  final String t = action.payload ?? '';
  final CreateListPageState newState = state.clone();
  newState.name = t;
  return newState;
}

CreateListPageState _setBackGround(CreateListPageState state, Action action) {
  final String t = action.payload ?? '';
  final CreateListPageState newState = state.clone();
  newState.backGroundUrl = t;
  return newState;
}

CreateListPageState _setDescription(CreateListPageState state, Action action) {
  final String t = action.payload ?? '';
  final CreateListPageState newState = state.clone();
  newState.description = t;
  return newState;
}
