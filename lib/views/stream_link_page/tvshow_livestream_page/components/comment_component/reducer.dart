import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<CommentState> buildReducer() {
  return asReducer(
    <Object, Reducer<CommentState>>{
      CommentAction.action: _onAction,
    },
  );
}

CommentState _onAction(CommentState state, Action action) {
  final CommentState newState = state.clone();
  return newState;
}
