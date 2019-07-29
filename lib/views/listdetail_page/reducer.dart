import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/listdetailmode.dart';
import 'package:movie/models/sortcondition.dart';

import 'action.dart';
import 'state.dart';

Reducer<ListDetailPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<ListDetailPageState>>{
      ListDetailPageAction.action: _onAction,
      ListDetailPageAction.setListDetail:_setListDetail,
      ListDetailPageAction.loadMore:_loadMore,
      ListDetailPageAction.setSort:_setSort,
    },
  );
}

ListDetailPageState _onAction(ListDetailPageState state, Action action) {
  final ListDetailPageState newState = state.clone();
  return newState;
}

ListDetailPageState _setListDetail(ListDetailPageState state, Action action) {
  final ListDetailModel model=action.payload??ListDetailModel.fromParams(results: []);
  final ListDetailPageState newState = state.clone();
  newState.listDetailModel=model;
  return newState;
}

ListDetailPageState _loadMore(ListDetailPageState state, Action action) {
  final ListDetailModel model=action.payload??ListDetailModel.fromParams(results: []);
  final ListDetailPageState newState = state.clone();
  newState.listDetailModel.results.addAll(model.results);
  newState.listDetailModel.page=model.page??newState.listDetailModel.page;
  return newState;
}

ListDetailPageState _setSort(ListDetailPageState state, Action action) {
  final SortCondition model=action.payload;
  final ListDetailPageState newState = state.clone();
  int index=state.sortBy.indexOf(model);
  newState.sortBy.forEach((f){f.isSelected=false;});
  newState.sortBy[index].isSelected=true;
  newState.sortType=model.value;
  newState.listDetailModel.results=[];
  return newState;
}