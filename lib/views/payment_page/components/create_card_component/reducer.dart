import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<CreateCardState> buildReducer() {
  return asReducer(
    <Object, Reducer<CreateCardState>>{
      CreateCardAction.action: _onAction,
      CreateCardAction.setInputIndex: _setInputIndex,
      CreateCardAction.loading: _loading,
    },
  );
}

CreateCardState _onAction(CreateCardState state, Action action) {
  final CreateCardState newState = state.clone();
  return newState;
}

CreateCardState _setInputIndex(CreateCardState state, Action action) {
  final int _index = action.payload;
  final CreateCardState newState = state.clone();
  newState.inputIndex = _index;
  return newState;
}

CreateCardState _loading(CreateCardState state, Action action) {
  final bool _loading = action.payload ?? false;
  final CreateCardState newState = state.clone();
  newState.loading = _loading;
  return newState;
}
