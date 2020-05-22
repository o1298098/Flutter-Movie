import 'package:fish_redux/fish_redux.dart';

enum PremiumInfoAction { action }

class PremiumInfoActionCreator {
  static Action onAction() {
    return const Action(PremiumInfoAction.action);
  }
}
