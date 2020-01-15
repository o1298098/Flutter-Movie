import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ImagesAction { action }

class ImagesActionCreator {
  static Action onAction() {
    return const Action(ImagesAction.action);
  }
}
