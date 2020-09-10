import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'action.dart';
import 'state.dart';

Effect<VideoCellState> buildEffect() {
  return combineEffects(<Object, Effect<VideoCellState>>{
    MovieCellAction.action: _onAction,
    MovieCellAction.movieCellTapped:_onMovieCellTapped,
  });
}

void _onAction(Action action, Context<VideoCellState> ctx) {
}
Future _onMovieCellTapped(Action action, Context<VideoCellState> ctx) async{
  await Navigator.of(ctx.context).pushNamed('moviedetailpage',arguments:{'movieid':action.payload});
}
