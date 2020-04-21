import 'package:fish_redux/fish_redux.dart';

enum MainInfoAction { action }

class MainInfoActionCreator {
  static Action onAction() {
    return const Action(MainInfoAction.action);
  }
}
