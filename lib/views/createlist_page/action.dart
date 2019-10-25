import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum CreateListPageAction {
  action,
  submit,
  setName,
  setBackGround,
  setDescription
}

class CreateListPageActionCreator {
  static Action onAction() {
    return const Action(CreateListPageAction.action);
  }

  static Action onSubmit() {
    return const Action(CreateListPageAction.submit);
  }

  static Action setBackGround(String t) {
    return Action(CreateListPageAction.setBackGround, payload: t);
  }

  static Action setName(String t) {
    return Action(CreateListPageAction.setName, payload: t);
  }

  static Action setDescription(String t) {
    return Action(CreateListPageAction.setDescription, payload: t);
  }
}
