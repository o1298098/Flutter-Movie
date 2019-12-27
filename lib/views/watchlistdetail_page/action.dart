import 'package:fish_redux/fish_redux.dart';

enum WatchlistDetailPageAction { action }

class WatchlistDetailPageActionCreator {
  static Action onAction() {
    return const Action(WatchlistDetailPageAction.action);
  }
}
