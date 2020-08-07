import 'package:fish_redux/fish_redux.dart';

enum TrendingCellAction { action, setLiked, onLikeTap }

class TrendingCellActionCreator {
  static Action onAction() {
    return const Action(TrendingCellAction.action);
  }

  static Action setLiked(bool liked, int index) {
    return Action(TrendingCellAction.setLiked, payload: [liked, index]);
  }

  static Action onLikeTap() {
    return const Action(TrendingCellAction.onLikeTap);
  }
}
