import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum FirebaseLoginPageAction { action }

class FirebaseLoginPageActionCreator {
  static Action onAction() {
    return const Action(FirebaseLoginPageAction.action);
  }
}
