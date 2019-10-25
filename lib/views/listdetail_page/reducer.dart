import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/listdetailmode.dart';
import 'package:movie/models/sortcondition.dart';

import 'action.dart';
import 'state.dart';

Reducer<ListDetailPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<ListDetailPageState>>{
      ListDetailPageAction.action: _onAction,
      ListDetailPageAction.setSort: _setSort,
    },
  );
}

ListDetailPageState _onAction(ListDetailPageState state, Action action) {
  final ListDetailPageState newState = state.clone();
  return newState;
}

ListDetailPageState _setSort(ListDetailPageState state, Action action) {
  final SortCondition model = action.payload;
  final ListDetailPageState newState = state.clone();
  int index = state.sortBy.indexOf(model);
  newState.sortBy.forEach((f) {
    f.isSelected = false;
  });
  newState.sortBy[index].isSelected = true;
  newState.sortType = model.value;
  return newState;
}
