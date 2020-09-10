import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/globalbasestate/state.dart';
import 'package:movie/models/base_api_model/user_list.dart';
import 'package:movie/models/app_user.dart';
import 'package:movie/views/mylists_page/listcell_component/state.dart';

class MyListsPageState extends MutableSource
    implements GlobalBaseState, Cloneable<MyListsPageState> {
  String accountId;
  ScrollController scrollController;
  bool isEdit;
  AnimationController animationController;
  AnimationController cellAnimationController;
  GlobalKey<AnimatedListState> listkey;
  UserListModel listData;

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
  AppUser user;

  @override
  Object getItemData(int index) => ListCellState(
      cellData: listData.data[index],
      cellAnimationController: cellAnimationController,
      animationController: animationController,
      isEdit: isEdit);

  @override
  String getItemType(int index) => 'listCell';

  @override
  int get itemCount => listData?.data?.length ?? 0;

  @override
  void setItemData(int index, Object data) {}
}

MyListsPageState initState(Map<String, dynamic> args) {
  MyListsPageState state = MyListsPageState();
  state.isEdit = false;
  state.listkey = GlobalKey<AnimatedListState>();
  return state;
}
