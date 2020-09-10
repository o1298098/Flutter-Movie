import 'package:fish_redux/fish_redux.dart';

enum CreateCardAction {
  action,
  nextTapped,
  backTapped,
  setInputIndex,
  loading,
  scan,
}

class CreateCardActionCreator {
  static Action onAction() {
    return const Action(CreateCardAction.action);
  }

  static Action nextTapped() {
    return const Action(CreateCardAction.nextTapped);
  }

  static Action backTapped() {
    return const Action(CreateCardAction.backTapped);
  }

  static Action setInputIndex(int index) {
    return Action(CreateCardAction.setInputIndex, payload: index);
  }

  static Action loading(bool loading) {
    return Action(CreateCardAction.loading, payload: loading);
  }

  static Action scan() {
    return const Action(CreateCardAction.scan);
  }
}
