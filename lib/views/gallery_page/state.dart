import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/image_model.dart';

class GalleryPageState implements Cloneable<GalleryPageState> {
  List<ImageData> images;
  AnimationController animationController;

  @override
  GalleryPageState clone() {
    return GalleryPageState()..images = images;
  }
}

GalleryPageState initState(Map<String, dynamic> args) {
  GalleryPageState state = GalleryPageState();
  state.images = args['images'];
  return state;
}
