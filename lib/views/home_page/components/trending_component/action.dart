import 'package:fish_redux/fish_redux.dart';

enum TrendingAction { action }

class TrendingActionCreator {
  static Action onAction() {
    return const Action(TrendingAction.action);
  }
}
