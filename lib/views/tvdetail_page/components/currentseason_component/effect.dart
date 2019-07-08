import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';
import 'action.dart';
import 'state.dart';

Effect<CurrentSeasonState> buildEffect() {
  return combineEffects(<Object, Effect<CurrentSeasonState>>{
    CurrentSeasonAction.action: _onAction,
    CurrentSeasonAction.cellTapped:_onCellTapped
  });
}

void _onAction(Action action, Context<CurrentSeasonState> ctx) {
}

Future _onCellTapped(Action action, Context<CurrentSeasonState> ctx) async{
  await Navigator.of(ctx.context).pushNamed('seasondetailpage',arguments: {'tvid':action.payload[0],'seasonNumber':action.payload[1],'name':action.payload[2],'posterpic':action.payload[3]});
}
