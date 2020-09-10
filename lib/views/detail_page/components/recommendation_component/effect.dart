import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<RecommendationsState> buildEffect() {
  return combineEffects(<Object, Effect<RecommendationsState>>{
    RecommendationsAction.action: _onAction,
  });
}

void _onAction(Action action, Context<RecommendationsState> ctx) {
}
