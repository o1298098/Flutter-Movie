import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<RecommendationState> buildEffect() {
  return combineEffects(<Object, Effect<RecommendationState>>{
    RecommendationAction.action: _onAction,
  });
}

void _onAction(Action action, Context<RecommendationState> ctx) {
}
