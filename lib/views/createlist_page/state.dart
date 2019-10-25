import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/globalbasestate/state.dart';

class CreateListPageState
    implements GlobalBaseState, Cloneable<CreateListPageState> {
  DocumentSnapshot listData;
  String name;
  String backGroundUrl;
  String description;
  TextEditingController nameTextController;
  TextEditingController backGroundTextController;
  TextEditingController descriptionTextController;
  @override
  CreateListPageState clone() {
    return CreateListPageState()
      ..listData = listData
      ..name = name
      ..backGroundUrl = backGroundUrl
      ..description = description
      ..user = user
      ..backGroundTextController = backGroundTextController
      ..nameTextController = nameTextController
      ..descriptionTextController = descriptionTextController;
  }

  @override
  Locale locale;

  @override
  Color themeColor;

  @override
  FirebaseUser user;
}

CreateListPageState initState(Map<String, dynamic> args) {
  CreateListPageState state = CreateListPageState();
  DocumentSnapshot _listData = args != null ? args['list'] : null;
  state.listData = _listData;
  state.name = _listData != null ? _listData.documentID : '';
  state.backGroundUrl = _listData != null ? _listData['backGroundUrl'] : '';
  state.description = _listData != null ? _listData['description'] : '';
  return state;
}
