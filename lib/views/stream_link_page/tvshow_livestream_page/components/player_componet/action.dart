import 'package:fish_redux/fish_redux.dart';

enum TvPlayerAction { action }

class TvPlayerActionCreator {
  static Action onAction() {
    return const Action(TvPlayerAction.action);
  }
}
