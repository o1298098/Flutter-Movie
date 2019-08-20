import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum WatchlistDetailPageAction { action }

class WatchlistDetailPageActionCreator {
  static Action onAction() {
    return const Action(WatchlistDetailPageAction.action);
  }
}
