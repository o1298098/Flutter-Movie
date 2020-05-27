import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<CreateAddressState> buildReducer() {
  return asReducer(
    <Object, Reducer<CreateAddressState>>{
      CreateAddressAction.action: _onAction,
    },
  );
}

CreateAddressState _onAction(CreateAddressState state, Action action) {
  final CreateAddressState newState = state.clone();
  return newState;
}
