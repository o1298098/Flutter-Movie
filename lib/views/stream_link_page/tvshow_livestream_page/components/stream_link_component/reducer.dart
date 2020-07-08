import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<StreamLinkState> buildReducer() {
  return asReducer(
    <Object, Reducer<StreamLinkState>>{
      StreamLinkAction.action: _onAction,
    },
  );
}

StreamLinkState _onAction(StreamLinkState state, Action action) {
  final StreamLinkState newState = state.clone();
  return newState;
}
