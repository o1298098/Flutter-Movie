import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum TvPlayerAction { action }

class TvPlayerActionCreator {
  static Action onAction() {
    return const Action(TvPlayerAction.action);
  }
}
