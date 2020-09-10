import 'package:fish_redux/fish_redux.dart';

enum PlanAction { action, unSubscribe, loading }

class PlanActionCreator {
  static Action onAction() {
    return const Action(PlanAction.action);
  }

  static Action unSubscribe() {
    return const Action(PlanAction.unSubscribe);
  }

  static Action loading(bool loading) {
    return Action(PlanAction.unSubscribe, payload: loading);
  }
}
