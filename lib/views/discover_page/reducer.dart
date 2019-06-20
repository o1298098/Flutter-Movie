import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<DiscoverPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<DiscoverPageState>>{
      DiscoverPageAction.action: _onAction,
    },
  );
}

DiscoverPageState _onAction(DiscoverPageState state, Action action) {
  final DiscoverPageState newState = state.clone();
  return newState;
}
