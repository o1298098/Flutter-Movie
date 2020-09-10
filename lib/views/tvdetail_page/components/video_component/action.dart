import 'package:fish_redux/fish_redux.dart';

enum VideoAction { action }

class VideoActionCreator {
  static Action onAction() {
    return const Action(VideoAction.action);
  }
}
