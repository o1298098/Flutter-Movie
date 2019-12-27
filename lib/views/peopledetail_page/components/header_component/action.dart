import 'package:fish_redux/fish_redux.dart';

enum HeaderAction { action, bioReadMore }

class HeaderActionCreator {
  static Action onAction() {
    return const Action(HeaderAction.action);
  }

  static Action bioReadMore() {
    return const Action(HeaderAction.bioReadMore);
  }
}
