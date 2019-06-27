import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<TimeLineState> buildEffect() {
  return combineEffects(<Object, Effect<TimeLineState>>{
    TimeLineAction.action: _onAction,
  });
}

void _onAction(Action action, Context<TimeLineState> ctx) {
}
