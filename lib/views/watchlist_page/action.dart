import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum WatchlistPageAction { action }

class WatchlistPageActionCreator {
  static Action onAction() {
    return const Action(WatchlistPageAction.action);
  }
}
