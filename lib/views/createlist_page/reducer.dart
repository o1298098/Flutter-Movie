import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<CreateListPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<CreateListPageState>>{
      CreateListPageAction.action: _onAction,
      CreateListPageAction.setBackground: _setBackground,
      CreateListPageAction.setLoading: _setLoading,
    },
  );
}

CreateListPageState _onAction(CreateListPageState state, Action action) {
  final CreateListPageState newState = state.clone();
  return newState;
}

CreateListPageState _setBackground(CreateListPageState state, Action action) {
  final String _url = action.payload;
  final CreateListPageState newState = state.clone();
  newState.backGroundUrl = _url;
  return newState;
}

CreateListPageState _setLoading(CreateListPageState state, Action action) {
  final bool _loading = action.payload;
  final CreateListPageState newState = state.clone();
  newState.loading = _loading;
  return newState;
}
