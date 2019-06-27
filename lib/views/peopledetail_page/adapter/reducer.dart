import 'package:fish_redux/fish_redux.dart';

import '../state.dart';
import 'action.dart';

Reducer<PeopleDetailPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<PeopleDetailPageState>>{
      PeopleAction.action: _onAction,
    },
  );
}

PeopleDetailPageState _onAction(PeopleDetailPageState state, Action action) {
  final PeopleDetailPageState newState = state.clone();
  return newState;
}
