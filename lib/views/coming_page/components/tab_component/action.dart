import 'package:fish_redux/fish_redux.dart';

enum TabAction { action }

class TabActionCreator {
  static Action onAction() {
    return const Action(TabAction.action);
  }
}
