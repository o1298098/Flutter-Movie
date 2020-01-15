import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum CastAction { action }

class CastActionCreator {
  static Action onAction() {
    return const Action(CastAction.action);
  }
}
