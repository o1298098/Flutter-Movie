import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ImagesAction { action,imageTappde,galleryImageTapped}

class ImagesActionCreator {
  static Action onAction() {
    return const Action(ImagesAction.action);
  }
  static Action onImageTapped(String url) {
    return Action(ImagesAction.imageTappde,payload: url);
  }
  static Action onGalleryImageTapped(int index) {
    return Action(ImagesAction.galleryImageTapped,payload: index);
  }
}
