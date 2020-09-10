import 'package:fish_redux/fish_redux.dart';

enum TabbarAction { action }

class TabbarActionCreator {
  static Action onAction() {
    return const Action(TabbarAction.action);
  }
}
