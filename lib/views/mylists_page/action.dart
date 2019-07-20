import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum MyListsPageAction { action }

class MyListsPageActionCreator {
  static Action onAction() {
    return const Action(MyListsPageAction.action);
  }
}
