import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/mylistmodel.dart';

//TODO replace with your own action
enum MyListsPageAction {
  action,
  setAccount,
  setList,
  loadMore,
  cellTapped,
  createList,
  onEdit,
  deleteList,
}

class MyListsPageActionCreator {
  static Action onAction() {
    return const Action(MyListsPageAction.action);
  }

  static Action setAccount(String accountid) {
    return Action(MyListsPageAction.setAccount, payload: accountid);
  }

  static Action setList(Stream<QuerySnapshot> list) {
    return Action(MyListsPageAction.setList, payload: list);
  }

  static Action loadMore(MyListModel list) {
    return Action(MyListsPageAction.loadMore, payload: list);
  }

  static Action cellTapped(DocumentSnapshot d) {
    return Action(MyListsPageAction.cellTapped, payload: d);
  }

  static Action createList({Object d}) {
    return Action(MyListsPageAction.createList, payload: d);
  }

  static Action onEdit(bool isEdit) {
    return Action(MyListsPageAction.onEdit, payload: isEdit);
  }

  static Action deleteList(DocumentSnapshot d) {
    return Action(MyListsPageAction.deleteList, payload: d);
  }
}
