import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'action.dart';
import 'state.dart';

Effect<Theme3State> buildEffect() {
  return combineEffects(<Object, Effect<Theme3State>>{
    Theme3Action.action: _onAction,
    Theme3Action.testTapped: _onTestTapped
  });
}

void _onAction(Action action, Context<Theme3State> ctx) {}
void _onTestTapped(Action action, Context<Theme3State> ctx) async {
  await Navigator.of(ctx.context).pushNamed('testPage');
}
