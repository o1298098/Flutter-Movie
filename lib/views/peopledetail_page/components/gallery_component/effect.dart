import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'action.dart';
import 'state.dart';

Effect<GalleryState> buildEffect() {
  return combineEffects(<Object, Effect<GalleryState>>{
    GalleryAction.action: _onAction,
    GalleryAction.viewMoreTapped: _viewMoreTapped,
  });
}

void _onAction(Action action, Context<GalleryState> ctx) {}

Future _viewMoreTapped(Action action, Context<GalleryState> ctx) async {
  await Navigator.of(ctx.context).pushNamed('GalleryPage',
      arguments: {'images': ctx.state.images.profiles});
}
