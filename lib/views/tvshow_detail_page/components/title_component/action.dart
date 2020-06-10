import 'package:fish_redux/fish_redux.dart';

enum TitleAction { action }

class TitleActionCreator {
  static Action onAction() {
    return const Action(TitleAction.action);
  }
}
