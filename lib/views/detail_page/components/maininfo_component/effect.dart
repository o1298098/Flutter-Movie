import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<MainInfoState> buildEffect() {
  return combineEffects(<Object, Effect<MainInfoState>>{
    MainInfoAction.action: _onAction,
  });
}

void _onAction(Action action, Context<MainInfoState> ctx) {}
