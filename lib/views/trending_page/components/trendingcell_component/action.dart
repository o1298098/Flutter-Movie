import 'package:fish_redux/fish_redux.dart';

enum TrendingCellAction { action }

class TrendingCellActionCreator {
  static Action onAction() {
    return const Action(TrendingCellAction.action);
  }
}
