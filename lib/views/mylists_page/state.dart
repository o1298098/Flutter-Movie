import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/mylistmodel.dart';

class MyListsPageState implements Cloneable<MyListsPageState> {
  String accountId;
  MyListModel myList;
  ScrollController scrollController;
  bool isEdit;
  AnimationController animationController;
  AnimationController cellAnimationController;
  GlobalKey<AnimatedListState> listkey;

  @override
  MyListsPageState clone() {
    return MyListsPageState()
    ..accountId=accountId
    ..myList=myList
    ..scrollController=scrollController
    ..isEdit=isEdit
    ..animationController=animationController
    ..cellAnimationController=cellAnimationController
    ..listkey=listkey;
  }
}

MyListsPageState initState(Map<String, dynamic> args) {
  MyListsPageState state=MyListsPageState();
  state.accountId=args['accountid'];
  state.myList=MyListModel.fromParams(results: []);
  state.isEdit=false;
  state.listkey=GlobalKey<AnimatedListState>();
  return state;
}
