import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PersonalInfoState> buildReducer() {
  return asReducer(
    <Object, Reducer<PersonalInfoState>>{
      PersonalInfoAction.action: _onAction,
    },
  );
}

PersonalInfoState _onAction(PersonalInfoState state, Action action) {
  final PersonalInfoState newState = state.clone();
  return newState;
}
