import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum GalleryPageAction { action }

class GalleryPageActionCreator {
  static Action onAction() {
    return const Action(GalleryPageAction.action);
  }
}
