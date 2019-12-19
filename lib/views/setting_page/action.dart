import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum SettingPageAction { action }

class SettingPageActionCreator {
  static Action onAction() {
    return const Action(SettingPageAction.action);
  }
}
