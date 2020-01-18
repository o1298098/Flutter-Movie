import 'package:fish_redux/fish_redux.dart';

enum ListCellAction { action }

class ListCellActionCreator {
  static Action onAction() {
    return const Action(ListCellAction.action);
  }
}
