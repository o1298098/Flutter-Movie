import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<KnownForState> buildReducer() {
  return asReducer(
    <Object, Reducer<KnownForState>>{
      KnownForAction.action: _onAction,
    },
  );
}

KnownForState _onAction(KnownForState state, Action action) {
  final KnownForState newState = state.clone();
  return newState;
}
