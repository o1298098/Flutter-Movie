import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/globalbasestate/store.dart';
import 'action.dart';
import 'state.dart';

Effect<MainPageState> buildEffect() {
  return combineEffects(<Object, Effect<MainPageState>>{
    MainPageAction.action: _onAction,
    Lifecycle.initState: _onInit
  });
}

void _onAction(Action action, Context<MainPageState> ctx) {}
void _onInit(Action action, Context<MainPageState> ctx) {
  var lastState;
  final void Function() unsubscribe = GlobalStore.store.subscribe(() {
    var newState = Theme.of(ctx.context).brightness;
    if (lastState != newState) {
      lastState = newState;
      ctx.forceUpdate();
    }
  });
}
