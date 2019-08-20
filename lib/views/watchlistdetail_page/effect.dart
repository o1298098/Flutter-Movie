import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'action.dart';
import 'state.dart';

Effect<WatchlistDetailPageState> buildEffect() {
  return combineEffects(<Object, Effect<WatchlistDetailPageState>>{
    WatchlistDetailPageAction.action: _onAction,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
  });
}

void _onAction(Action action, Context<WatchlistDetailPageState> ctx) {}

Future _onInit(Action action, Context<WatchlistDetailPageState> ctx) async {
  final Object ticker = ctx.stfState;
  ctx.state.animationController = AnimationController(
      vsync: ticker,
      duration: Duration(milliseconds: 1500),
      reverseDuration: Duration(milliseconds: 300));
  await Future.delayed(Duration(milliseconds: 600),
      () => ctx.state.animationController.forward());
}

void _onDispose(Action action, Context<WatchlistDetailPageState> ctx) {
  ctx.state.animationController.dispose();
}
