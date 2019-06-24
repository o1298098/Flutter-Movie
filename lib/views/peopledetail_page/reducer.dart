import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PeopleDetailPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<PeopleDetailPageState>>{
      PeopleDetailPageAction.action: _onAction,
    },
  );
}

PeopleDetailPageState _onAction(PeopleDetailPageState state, Action action) {
  final PeopleDetailPageState newState = state.clone();
  return newState;
}
