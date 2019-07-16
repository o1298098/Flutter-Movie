import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum InfoAction { action,externalTapped }

class InfoActionCreator {
  static Action onAction() {
    return const Action(InfoAction.action);
  }
   static Action onExternalTapped(String url) {
    return Action(InfoAction.externalTapped,payload: url);
  }
}
