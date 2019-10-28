import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/sortcondition.dart';

class AllStreamLinkPageState implements Cloneable<AllStreamLinkPageState> {
  QuerySnapshot streamList;
  ScrollController scrollController;
  GlobalKey<ScaffoldState> scaffoldKey;
  AnimationController animationController;
  List<SortCondition> sortTypes;
  String orderBy;
  bool desc;

  @override
  AllStreamLinkPageState clone() {
    return AllStreamLinkPageState()
      ..streamList = streamList
      ..scrollController = scrollController
      ..scaffoldKey = scaffoldKey
      ..animationController = animationController
      ..sortTypes = sortTypes
      ..orderBy = orderBy
      ..desc = desc;
  }
}

AllStreamLinkPageState initState(Map<String, dynamic> args) {
  return AllStreamLinkPageState()
    ..scaffoldKey = GlobalKey<ScaffoldState>()
    ..orderBy = 'updateTime'
    ..desc = true
    ..sortTypes = [
      SortCondition(
          isSelected: true,
          name: 'UpdateTime Desc',
          value: ['updateTime', true]),
      SortCondition(
          isSelected: false,
          name: 'UpdateTime Asc',
          value: ['updateTime', false]),
      SortCondition(
          isSelected: false, name: 'Name Desc', value: ['name', true]),
      SortCondition(
          isSelected: false, name: 'Name Asc', value: ['name', false]),
    ];
}
