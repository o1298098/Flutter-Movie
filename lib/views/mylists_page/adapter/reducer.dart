import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/user_list.dart';
import 'package:movie/views/mylists_page/state.dart';
import '../listcell_component/action.dart' as listcell_action;
import 'action.dart';

Reducer<MyListsPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<MyListsPageState>>{
      MyListAction.action: _onAction,
      listcell_action.ListCellAction.onDeleteList: _onDeleteList,
    },
  );
}

MyListsPageState _onAction(MyListsPageState state, Action action) {
  final MyListsPageState newState = state.clone();
  return newState;
}

MyListsPageState _onDeleteList(MyListsPageState state, Action action) {
  final UserList _list = action.payload;
  final MyListsPageState newState = state.clone();
  if (_list != null) (state.listData).data.remove(_list);
  return newState;
}
