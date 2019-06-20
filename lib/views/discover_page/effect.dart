import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<DiscoverPageState> buildEffect() {
  return combineEffects(<Object, Effect<DiscoverPageState>>{
    DiscoverPageAction.action: _onAction,
  });
}

void _onAction(Action action, Context<DiscoverPageState> ctx) {
}
