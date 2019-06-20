import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum TVCellsAction { action }

class TVCellsActionCreator {
  static Action onAction() {
    return const Action(TVCellsAction.action);
  }
}
