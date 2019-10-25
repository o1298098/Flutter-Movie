import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/globalbasestate/state.dart';
import 'package:movie/models/mylistmodel.dart';

class MyListsPageState implements GlobalBaseState, Cloneable<MyListsPageState> {
  String accountId;
  ScrollController scrollController;
  bool isEdit;
  AnimationController animationController;
  AnimationController cellAnimationController;
  GlobalKey<AnimatedListState> listkey;
  Stream<QuerySnapshot> listData;

  @override
  MyListsPageState clone() {
    return MyListsPageState()
      ..accountId = accountId
      ..scrollController = scrollController
      ..isEdit = isEdit
      ..animationController = animationController
      ..cellAnimationController = cellAnimationController
      ..listkey = listkey
      ..user = user
      ..listData = listData;
  }

  @override
  Locale locale;

  @override
  Color themeColor;

  @override
  FirebaseUser user;
}

MyListsPageState initState(Map<String, dynamic> args) {
  MyListsPageState state = MyListsPageState();
  state.accountId = args['accountid'];
  state.isEdit = false;
  state.listkey = GlobalKey<AnimatedListState>();
  return state;
}
