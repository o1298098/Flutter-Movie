import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/user_list.dart';

enum ListCellAction {
  action,
  onEdit,
  deleteList,
  onDeleteList,
  cellTapped,
}

class ListCellActionCreator {
  static Action onAction() {
    return const Action(ListCellAction.action);
  }

  static Action onEdit({Object d}) {
    return Action(ListCellAction.onEdit, payload: d);
  }

  static Action cellTapped(UserList d) {
    return Action(ListCellAction.cellTapped, payload: d);
  }

  static Action deleteList(UserList d) {
    return Action(ListCellAction.deleteList, payload: d);
  }

  static Action onDeleteList(UserList d) {
    return Action(ListCellAction.onDeleteList, payload: d);
  }
}
