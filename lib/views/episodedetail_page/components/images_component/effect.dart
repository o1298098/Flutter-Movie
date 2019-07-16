import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter/widgets.dart' hide Action;
import 'package:movie/customwidgets/galleryphotoviewwrapper.dart';
import 'package:movie/customwidgets/imageviewwrapper.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'action.dart';
import 'state.dart';

Effect<ImagesState> buildEffect() {
  return combineEffects(<Object, Effect<ImagesState>>{
    ImagesAction.action: _onAction,
    ImagesAction.imageTappde: _onImageTapped,
    ImagesAction.galleryImageTapped:_onGalleryImageTapped
  });
}

void _onAction(Action action, Context<ImagesState> ctx) {}

Future _onImageTapped(Action action, Context<ImagesState> ctx) async {
  String url=action.payload??'';
  await Navigator.of(ctx.context).push(MaterialPageRoute(
    builder: (context) => HeroPhotoViewWrapper(
      url: url,
        ),
  ));
}

Future _onGalleryImageTapped(Action action, Context<ImagesState> ctx) async {
  await Navigator.of(ctx.context).push(MaterialPageRoute(
    builder: (context) => GalleryPhotoViewWrapper(
      imageSize: ImageSize.w500,
      galleryItems: ctx.state.images.stills,
      initialIndex: action.payload,
        ),
  ));
}

