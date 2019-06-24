import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/globalbasestate/state.dart';
import 'package:movie/models/videolist.dart';

class AccountPageState implements GlobalBaseState<AccountPageState> {

  VideoListModel moiveListModel;
  ScrollController scrollController;
  @override
  AccountPageState clone() {
    return AccountPageState()
    ..moiveListModel=moiveListModel
    ..scrollController=scrollController;
  }

  @override
  Color themeColor;
}

AccountPageState initState(Map<String, dynamic> args) {
  return AccountPageState();
}
