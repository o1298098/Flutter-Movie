import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum PremiumPageAction { action }

class PremiumPageActionCreator {
  static Action onAction() {
    return const Action(PremiumPageAction.action);
  }
}
