import 'package:fish_redux/fish_redux.dart';

enum GalleryPageAction { action }

class GalleryPageActionCreator {
  static Action onAction() {
    return const Action(GalleryPageAction.action);
  }
}
