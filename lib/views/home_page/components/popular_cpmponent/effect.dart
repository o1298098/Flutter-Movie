import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';
import 'action.dart';
import 'state.dart';

Effect<PopularState> buildEffect() {
  return combineEffects(<Object, Effect<PopularState>>{
    PopularAction.action: _onAction,
    PopularAction.cellTapped:_onCellTapped
  });
}

void _onAction(Action action, Context<PopularState> ctx) {
}

Future _onCellTapped(Action action, Context<PopularState> ctx) async{
  if(ctx.state.showmovie)
  await Navigator.of(ctx.context).pushNamed('moviedetailpage',arguments:{'movieid':action.payload[0],'bgpic':action.payload[1]});
  else
  await Navigator.of(ctx.context).pushNamed('tvdetailpage',arguments:{'tvid':action.payload[0],'bgpic':action.payload[1]});
}
