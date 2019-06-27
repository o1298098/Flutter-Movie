import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum PersonalInfoAction { action }

class PersonalInfoActionCreator {
  static Action onAction() {
    return const Action(PersonalInfoAction.action);
  }
}
