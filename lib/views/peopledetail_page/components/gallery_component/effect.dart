import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/views/gallery_page/page.dart';
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
  await Navigator.of(ctx.context)
      .push(PageRouteBuilder(pageBuilder: (context, animation, secAnimation) {
    return FadeTransition(
      opacity: animation,
      child: GalleryPage().buildPage({'images': ctx.state.images.profiles}),
    );
  }));
}
