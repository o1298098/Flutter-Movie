import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/mylistmodel.dart';

//TODO replace with your own action
enum MyListsPageAction { action,setAccount,setList,loadMore,cellTapped,onEdit}

class MyListsPageActionCreator {
  static Action onAction() {
    return const Action(MyListsPageAction.action);
  }
  static Action setAccount(String accountid) {
    return Action(MyListsPageAction.setAccount,payload: accountid);
  }
  static Action setList(MyListModel list) {
    return Action(MyListsPageAction.setList,payload: list);
  }
  static Action loadMore(MyListModel list) {
    return Action(MyListsPageAction.loadMore,payload: list);
  }
  static Action cellTapped(int listid) {
    return Action(MyListsPageAction.cellTapped,payload: listid);
  }
  static Action onEdit(bool isEdit) {
    return Action(MyListsPageAction.onEdit,payload: isEdit);
  }
}
