import 'package:fish_redux/fish_redux.dart';

enum HeaderAction { action }

class HeaderActionCreator {
  static Action onAction() {
    return const Action(HeaderAction.action);
  }
}
