import 'package:fish_redux/fish_redux.dart';

enum CreateCardAction {
  action,
}

class CreateCardActionCreator {
  static Action onAction() {
    return const Action(CreateCardAction.action);
  }
}
