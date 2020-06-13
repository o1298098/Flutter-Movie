import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'action.dart';
import 'state.dart';

Effect<SeasonsPageState> buildEffect() {
  return combineEffects(<Object, Effect<SeasonsPageState>>{
    SeasonsPageAction.action: _onAction,
    SeasonsPageAction.cellTapped: _onCellTapped,
    Lifecycle.initState: _onInit,
    Lifecycle.build: _onBuild,
    Lifecycle.dispose: _onDispose,
  });
}

void _onAction(Action action, Context<SeasonsPageState> ctx) {}

void _onInit(Action action, Context<SeasonsPageState> ctx) {
  final Object ticker = ctx.stfState;
  ctx.state.animationController = AnimationController(
      vsync: ticker,
      duration: Duration(milliseconds: 400 * ctx.state.seasons.length));
}

void _onBuild(Action action, Context<SeasonsPageState> ctx) {
  Future.delayed(const Duration(milliseconds: 500),
      () => ctx.state.animationController.forward());
}

void _onDispose(Action action, Context<SeasonsPageState> ctx) {
  ctx.state.animationController.dispose();
}

Future _onCellTapped(Action action, Context<SeasonsPageState> ctx) async {
  await Navigator.of(ctx.context).pushNamed('seasondetailpage', arguments: {
    'tvid': action.payload[0],
    'seasonNumber': action.payload[1],
    'name': action.payload[2],
    'posterpic': action.payload[3]
  });
}
