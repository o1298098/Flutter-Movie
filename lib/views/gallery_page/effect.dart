import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'action.dart';
import 'state.dart';

Effect<GalleryPageState> buildEffect() {
  return combineEffects(<Object, Effect<GalleryPageState>>{
    GalleryPageAction.action: _onAction,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
  });
}

void _onAction(Action action, Context<GalleryPageState> ctx) {}

void _onInit(Action action, Context<GalleryPageState> ctx) {
  final Object ticker = ctx.stfState;
  ctx.state.animationController =
      AnimationController(vsync: ticker, duration: Duration(milliseconds: 600));
}

void _onDispose(Action action, Context<GalleryPageState> ctx) {
  ctx.state.animationController.dispose();
}
