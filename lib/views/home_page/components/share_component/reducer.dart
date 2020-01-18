import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Reducer<ShareState> buildReducer() {
  return asReducer(
    <Object, Reducer<ShareState>>{
      ShareAction.action: _onAction,
      ShareAction.shareFilterChanged: _onShareFilterChanged,
    },
  );
}

ShareState _onAction(ShareState state, Action action) {
  final ShareState newState = state.clone();
  return newState;
}

ShareState _onShareFilterChanged(ShareState state, Action action) {
  final bool e = action.payload ?? true;
  final ShareState newState = state.clone();
  newState.showShareMovie = e;
  return newState;
}
