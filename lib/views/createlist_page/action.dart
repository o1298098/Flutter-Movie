import 'package:fish_redux/fish_redux.dart';

enum CreateListPageAction {
  action,
  submit,
}

class CreateListPageActionCreator {
  static Action onAction() {
    return const Action(CreateListPageAction.action);
  }

  static Action onSubmit() {
    return const Action(CreateListPageAction.submit);
  }
}
