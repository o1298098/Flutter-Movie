import 'package:fish_redux/fish_redux.dart';

enum SeasonAction { action }

class SeasonActionCreator {
  static Action onAction() {
    return const Action(SeasonAction.action);
  }
}
