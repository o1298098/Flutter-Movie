import 'package:fish_redux/fish_redux.dart';

enum WatchlistDetailPageAction { action, meidaTap }

class WatchlistDetailPageActionCreator {
  static Action onAction() {
    return const Action(WatchlistDetailPageAction.action);
  }

  static Action meidaTap() {
    return const Action(WatchlistDetailPageAction.meidaTap);
  }
}
