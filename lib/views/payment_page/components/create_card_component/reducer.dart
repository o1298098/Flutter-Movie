import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<CreateCardState> buildReducer() {
  return asReducer(
    <Object, Reducer<CreateCardState>>{
      CreateCardAction.action: _onAction,
    },
  );
}

CreateCardState _onAction(CreateCardState state, Action action) {
  final CreateCardState newState = state.clone();
  return newState;
}
