import 'package:fish_redux/fish_redux.dart';

enum HeaderAction {
  action,
  widthChanged,
}

class HeaderActionCreator {
  static Action onAction() {
    return const Action(HeaderAction.action);
  }

  static Action widthChanged(bool d) {
    return Action(HeaderAction.widthChanged, payload: d);
  }
}
