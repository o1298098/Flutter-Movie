import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Reducer<HeaderState> buildReducer() {
  return asReducer(
    <Object, Reducer<HeaderState>>{
      HeaderAction.action: _onAction,
      HeaderAction.headerFilterChanged: _onHeaderFilterChanged,
    },
  );
}

HeaderState _onAction(HeaderState state, Action action) {
  final HeaderState newState = state.clone();
  return newState;
}

HeaderState _onHeaderFilterChanged(HeaderState state, Action action) {
  final bool e = action.payload ?? true;
  final HeaderState newState = state.clone();
  newState.showHeaderMovie = e;
  return newState;
}
