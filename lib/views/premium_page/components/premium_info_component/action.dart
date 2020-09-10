import 'package:fish_redux/fish_redux.dart';

enum PremiumInfoAction { action, subscribeChanged }

class PremiumInfoActionCreator {
  static Action onAction() {
    return const Action(PremiumInfoAction.action);
  }

  static Action subscribeChanged() {
    return const Action(PremiumInfoAction.subscribeChanged);
  }
}
