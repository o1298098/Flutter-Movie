import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/enums/list_sort_type.dart';
import 'package:movie/models/listdetailmode.dart';
import 'package:movie/models/sortcondition.dart';
import 'package:screenshot/screenshot.dart';

class ListDetailPageState implements Cloneable<ListDetailPageState> {

 int listId;
 ListDetailModel listDetailModel;
 ScrollController scrollController;
 List<SortCondition> sortBy;
 String sortType;

  @override
  ListDetailPageState clone() {
    return ListDetailPageState()
    ..listDetailModel=listDetailModel
    ..listId=listId
    ..sortBy=sortBy
    ..sortType=sortType
    ..scrollController=scrollController;
  }
}

ListDetailPageState initState(Map<String, dynamic> args) {
  ListDetailPageState state=ListDetailPageState();
  state.listId=args['listId'];
  state.sortBy=<SortCondition>[
    SortCondition(isSelected: true,name: 'Original Order',value: ListSortType.originalOrderAsc),
    SortCondition(isSelected: false,name: 'Rating',value: ListSortType.voteAverageDesc),
    SortCondition(isSelected: false,name: 'Release Date',value: ListSortType.releaseDateDesc),
    SortCondition(isSelected: false,name: 'Title',value: ListSortType.titleAsc),
  ];
  state.sortType=ListSortType.originalOrderAsc;
  state.listDetailModel=ListDetailModel.fromParams(results: []);
  return state;
}
