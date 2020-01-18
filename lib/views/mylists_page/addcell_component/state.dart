import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/views/mylists_page/state.dart';

class AddCellState implements Cloneable<AddCellState> {
  AnimationController animationController;
  @override
  AddCellState clone() {
    return AddCellState();
  }
}

class AddCellConnector extends ConnOp<MyListsPageState, AddCellState> {
  @override
  AddCellState get(MyListsPageState state) {
    AddCellState mstate = AddCellState();
    mstate.animationController = state.animationController;
    return mstate;
  }
}
