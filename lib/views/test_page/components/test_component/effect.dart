import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<TestState> buildEffect() {
  return combineEffects(<Object, Effect<TestState>>{
    TestAction.action: _onAction,
  });
}

void _onAction(Action action, Context<TestState> ctx) {}
