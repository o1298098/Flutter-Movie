import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Reducer<SeasonState> buildReducer() {
  return asReducer(
    <Object, Reducer<SeasonState>>{
      SeasonAction.action: _onAction,
    },
  );
}

SeasonState _onAction(SeasonState state, Action action) {
  final SeasonState newState = state.clone();
  return newState;
}
