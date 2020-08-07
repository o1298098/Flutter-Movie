import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/globalbasestate/state.dart';
import 'package:movie/models/base_api_model/user_list.dart';
import 'package:movie/models/app_user.dart';

class CreateListPageState
    implements GlobalBaseState, Cloneable<CreateListPageState> {
  UserList listData;
  String name;
  String backGroundUrl;
  String description;
  TextEditingController nameTextController;
  TextEditingController descriptionTextController;
  FocusNode nameFoucsNode;
  FocusNode descriptionFoucsNode;
  bool loading;
  @override
  CreateListPageState clone() {
    return CreateListPageState()
      ..listData = listData
      ..name = name
      ..backGroundUrl = backGroundUrl
      ..description = description
      ..user = user
      ..nameTextController = nameTextController
      ..descriptionTextController = descriptionTextController
      ..nameFoucsNode = nameFoucsNode
      ..descriptionFoucsNode = descriptionFoucsNode
      ..loading = loading;
  }

  @override
  Locale locale;

  @override
  Color themeColor;

  @override
  AppUser user;
}

CreateListPageState initState(Map<String, dynamic> args) {
  CreateListPageState state = CreateListPageState();
  UserList _listData = args != null ? args['list'] : null;
  state.listData = _listData;
  state.name = _listData != null ? _listData.listName : '';
  state.backGroundUrl = _listData != null ? _listData.backGroundUrl : '';
  state.description = _listData != null ? _listData.description : '';
  state.nameFoucsNode = FocusNode();
  state.descriptionFoucsNode = FocusNode();
  state.loading = false;
  return state;
}
