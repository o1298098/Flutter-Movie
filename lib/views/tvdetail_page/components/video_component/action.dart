import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum VideoAction { action }

class VideoActionCreator {
  static Action onAction() {
    return const Action(VideoAction.action);
  }
}
