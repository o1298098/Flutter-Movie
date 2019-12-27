import 'package:fish_redux/fish_redux.dart';

enum GalleryAction { action, imageCellTapped, viewMoreTapped }

class GalleryActionCreator {
  static Action onAction() {
    return const Action(GalleryAction.action);
  }

  static Action viewMoreTapped() {
    return const Action(GalleryAction.viewMoreTapped);
  }
}
