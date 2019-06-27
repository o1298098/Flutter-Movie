import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum KnownForAction { action }

class KnownForActionCreator {
  static Action onAction() {
    return const Action(KnownForAction.action);
  }
}
