import 'package:fish_redux/fish_redux.dart';

enum TrendingAdapterAction { action }

class TrendingAdapterActionCreator {
  static Action onAction() {
    return const Action(TrendingAdapterAction.action);
  }
}
