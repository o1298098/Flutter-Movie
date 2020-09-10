import 'package:fish_redux/fish_redux.dart';

enum CreateListPageAction {
  action,
  uploadBackground,
  setBackground,
  setLoading,
  submit,
}

class CreateListPageActionCreator {
  static Action onAction() {
    return const Action(CreateListPageAction.action);
  }

  static Action onSubmit() {
    return const Action(CreateListPageAction.submit);
  }

  static Action uploadBackground() {
    return const Action(CreateListPageAction.uploadBackground);
  }

  static Action setBackground(String url) {
    return Action(CreateListPageAction.setBackground, payload: url);
  }

  static Action setLoading(bool loading) {
    return Action(CreateListPageAction.setLoading, payload: loading);
  }
}
