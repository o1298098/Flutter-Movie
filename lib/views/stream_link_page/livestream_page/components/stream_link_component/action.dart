import 'package:fish_redux/fish_redux.dart';

enum StreamLinkAction { action }

class StreamLinkActionCreator {
  static Action onAction() {
    return const Action(StreamLinkAction.action);
  }
}
