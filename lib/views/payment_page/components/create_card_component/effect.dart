import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<CreateCardState> buildEffect() {
  return combineEffects(<Object, Effect<CreateCardState>>{
    CreateCardAction.action: _onAction,
    Lifecycle.initState: _onInit,
  });
}

void _onAction(Action action, Context<CreateCardState> ctx) {}

void _onInit(Action action, Context<CreateCardState> ctx) async {}
