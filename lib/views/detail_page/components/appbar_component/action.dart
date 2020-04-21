import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum AppBarAction { action }

class AppBarActionCreator {
  static Action onAction() {
    return const Action(AppBarAction.action);
  }
}
