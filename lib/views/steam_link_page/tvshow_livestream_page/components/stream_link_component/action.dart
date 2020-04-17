import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum StreamLinkAction { action }

class StreamLinkActionCreator {
  static Action onAction() {
    return const Action(StreamLinkAction.action);
  }
}
