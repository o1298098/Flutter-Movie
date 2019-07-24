import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/listdetailmode.dart';

class ListDetailPageState implements Cloneable<ListDetailPageState> {

 int listId;
 ListDetailModel listDetailModel;
 ScrollController scrollController;

  @override
  ListDetailPageState clone() {
    return ListDetailPageState()
    ..listDetailModel=listDetailModel
    ..listId=listId
    ..scrollController=scrollController;
  }
}

ListDetailPageState initState(Map<String, dynamic> args) {
  ListDetailPageState state=ListDetailPageState();
  state.listId=args['listId'];
  state.listDetailModel=ListDetailModel.fromParams(results: []);
  return state;
}
