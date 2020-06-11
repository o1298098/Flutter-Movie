import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/creditsmodel.dart';

enum CastAction {
  action,
  castCellTapped,
}

class CastActionCreator {
  static Action onAction() {
    return const Action(CastAction.action);
  }

  static Action onCastCellTapped(CastData cast) {
    return Action(CastAction.castCellTapped, payload: cast);
  }
}
