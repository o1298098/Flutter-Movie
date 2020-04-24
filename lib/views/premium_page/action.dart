import 'package:fish_redux/fish_redux.dart';

enum PremiumPageAction { action }

class PremiumPageActionCreator {
  static Action onAction() {
    return const Action(PremiumPageAction.action);
  }
}
