import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum TimeLineAction { action,actingChanged}

class TimeLineActionCreator {
  static Action onAction() {
    return const Action(TimeLineAction.action);
  }
   static Action onActingChanged(bool d) {
    return Action(TimeLineAction.actingChanged,payload: d);
  }
}
