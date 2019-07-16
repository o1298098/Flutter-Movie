import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum HistoryAction { action }

class HistoryActionCreator {
  static Action onAction() {
    return const Action(HistoryAction.action);
  }
}
