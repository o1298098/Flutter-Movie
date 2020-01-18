import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/base_api_model/user_list.dart';

class ListCellState implements Cloneable<ListCellState> {
  UserList cellData;
  AnimationController cellAnimationController;

  AnimationController animationController;
  bool isEdit;

  ListCellState(
      {this.cellAnimationController,
      this.cellData,
      this.isEdit,
      this.animationController});
  @override
  ListCellState clone() {
    return ListCellState()..cellData = cellData;
  }
}

ListCellState initState(Map<String, dynamic> args) {
  return ListCellState();
}
