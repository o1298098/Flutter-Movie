import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'action.dart';
import 'state.dart';

Effect<MovieCellsState> buildEffect() {
  return combineEffects(<Object, Effect<MovieCellsState>>{
    MovieCellsAction.action: _onAction,
    MovieCellsAction.celltapped:_onCellTapped
  });
}

void _onAction(Action action, Context<MovieCellsState> ctx) {
}
Future _onCellTapped(Action action, Context<MovieCellsState> ctx) async{
  await Navigator.of(ctx.context).pushNamed('moviedetailpage',arguments:{'movieid':action.payload[0],'bgpic':action.payload[1],'title':action.payload[2],'posterpic':action.payload[3]});
}
