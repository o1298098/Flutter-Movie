import 'package:fish_redux/fish_redux.dart';

enum MyListAction { action }

class MyListActionCreator {
  static Action onAction() {
    return const Action(MyListAction.action);
  }
}
