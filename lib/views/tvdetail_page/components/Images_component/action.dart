import 'package:fish_redux/fish_redux.dart';

enum ImagesAction { action }

class ImagesActionCreator {
  static Action onAction() {
    return const Action(ImagesAction.action);
  }
}
