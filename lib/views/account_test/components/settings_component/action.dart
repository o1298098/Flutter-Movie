import 'package:fish_redux/fish_redux.dart';

enum SettingsAction { action }

class SettingsActionCreator {
  static Action onAction() {
    return const Action(SettingsAction.action);
  }
}
