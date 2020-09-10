import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<HeaderState> buildEffect() {
  return combineEffects(<Object, Effect<HeaderState>>{
    HeaderAction.action: _onAction,
    HeaderAction.bioReadMore: _bioReadMore
  });
}

void _onAction(Action action, Context<HeaderState> ctx) {}
void _bioReadMore(Action action, Context<HeaderState> ctx) {}
