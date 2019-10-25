import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/globalbasestate/state.dart';
import 'package:movie/models/enums/list_sort_type.dart';
import 'package:movie/models/listdetailmode.dart';
import 'package:movie/models/sortcondition.dart';
import 'package:screenshot/screenshot.dart';

class ListDetailPageState
    implements GlobalBaseState, Cloneable<ListDetailPageState> {
  String listId;
  DocumentSnapshot listDetailModel;
  ScrollController scrollController;
  List<SortCondition> sortBy;
  String sortType;

  @override
  ListDetailPageState clone() {
    return ListDetailPageState()
      ..listDetailModel = listDetailModel
      ..listId = listId
      ..sortBy = sortBy
      ..sortType = sortType
      ..scrollController = scrollController
      ..user = user;
  }

  @override
  Locale locale;

  @override
  Color themeColor;

  @override
  FirebaseUser user;
}

ListDetailPageState initState(Map<String, dynamic> args) {
  ListDetailPageState state = ListDetailPageState();
  state.listDetailModel = args['list'];
  state.sortBy = <SortCondition>[
    SortCondition(
        isSelected: true,
        name: 'Original Order',
        value: ListSortType.originalOrderAsc),
    SortCondition(
        isSelected: false, name: 'Rating', value: ListSortType.voteAverageDesc),
    SortCondition(
        isSelected: false,
        name: 'Release Date',
        value: ListSortType.releaseDateDesc),
    SortCondition(
        isSelected: false, name: 'Title', value: ListSortType.titleAsc),
  ];
  state.sortType = ListSortType.originalOrderAsc;
  return state;
}
