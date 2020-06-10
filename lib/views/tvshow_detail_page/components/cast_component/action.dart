import 'package:fish_redux/fish_redux.dart';

enum CastAction { action }

class CastActionCreator {
  static Action onAction() {
    return const Action(CastAction.action);
  }
}
