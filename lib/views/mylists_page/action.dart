import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/user_list.dart';
import 'package:movie/models/mylist_model.dart';

enum MyListsPageAction {
  action,
  setAccount,
  setList,
  loadMore,
  createList,
  onEdit,
}

class MyListsPageActionCreator {
  static Action onAction() {
    return const Action(MyListsPageAction.action);
  }

  static Action setAccount(String accountid) {
    return Action(MyListsPageAction.setAccount, payload: accountid);
  }

  static Action setList(UserListModel list) {
    return Action(MyListsPageAction.setList, payload: list);
  }

  static Action loadMore(MyListModel list) {
    return Action(MyListsPageAction.loadMore, payload: list);
  }

  static Action createList({Object d}) {
    return Action(MyListsPageAction.createList, payload: d);
  }

  static Action onEdit(bool isEdit) {
    return Action(MyListsPageAction.onEdit, payload: isEdit);
  }
}
