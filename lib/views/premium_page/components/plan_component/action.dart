import 'package:fish_redux/fish_redux.dart';

enum PlanAction { action }

class PlanActionCreator {
  static Action onAction() {
    return const Action(PlanAction.action);
  }
}
