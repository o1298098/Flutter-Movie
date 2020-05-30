import 'package:fish_redux/fish_redux.dart';

enum CreateCardAction {
  action,
  nextTapped,
  setInputIndex,
}

class CreateCardActionCreator {
  static Action onAction() {
    return const Action(CreateCardAction.action);
  }

  static Action nextTapped() {
    return const Action(CreateCardAction.nextTapped);
  }

  static Action setInputIndex() {
    return const Action(CreateCardAction.setInputIndex);
  }
}
