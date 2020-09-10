import 'package:fish_redux/fish_redux.dart';

enum PersonalInfoAction { action }

class PersonalInfoActionCreator {
  static Action onAction() {
    return const Action(PersonalInfoAction.action);
  }
}
