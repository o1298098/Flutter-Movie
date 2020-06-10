import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<RecommendationState> buildReducer() {
  return asReducer(
    <Object, Reducer<RecommendationState>>{
      RecommendationAction.action: _onAction,
    },
  );
}

RecommendationState _onAction(RecommendationState state, Action action) {
  final RecommendationState newState = state.clone();
  return newState;
}
