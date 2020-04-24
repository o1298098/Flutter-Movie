import 'package:fish_redux/fish_redux.dart';

enum AppBarAction { action }

class AppBarActionCreator {
  static Action onAction() {
    return const Action(AppBarAction.action);
  }
}
