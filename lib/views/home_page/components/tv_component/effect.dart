import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'action.dart';
import 'state.dart';

Effect<TVCellsState> buildEffect() {
  return combineEffects(<Object, Effect<TVCellsState>>{
    TVCellsAction.action: _onAction,
    TVCellsAction.celltapped:_onCellTapped
  });
}

void _onAction(Action action, Context<TVCellsState> ctx) {
}

Future _onCellTapped(Action action, Context<TVCellsState> ctx) async{
  await Navigator.of(ctx.context).pushNamed('tvdetailpage',arguments:{'tvid':action.payload[0],'bgpic':action.payload[1],'name':action.payload[2],'posterpic':action.payload[3]});
}
