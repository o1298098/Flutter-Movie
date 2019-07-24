import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/mylistmodel.dart';

class MyListsPageState implements Cloneable<MyListsPageState> {
  String accountId;
  MyListModel myList;
  ScrollController scrollController;

  @override
  MyListsPageState clone() {
    return MyListsPageState()
    ..accountId=accountId
    ..myList=myList
    ..scrollController=scrollController;
  }
}

MyListsPageState initState(Map<String, dynamic> args) {
  MyListsPageState state=MyListsPageState();
  state.accountId=args['accountid'];
  state.myList=MyListModel.fromParams(results: []);
  return state;
}
