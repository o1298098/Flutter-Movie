import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart'hide Action;
import 'action.dart';
import 'state.dart';

Effect<SeasonCastState> buildEffect() {
  return combineEffects(<Object, Effect<SeasonCastState>>{
    SeasonCastAction.action: _onAction,
    SeasonCastAction.castCellTapped:_onCastCellTapped,
  });
}

void _onAction(Action action, Context<SeasonCastState> ctx) {
}
Future _onCastCellTapped(Action action, Context<SeasonCastState> ctx) async{
    await Navigator.of(ctx.context).pushNamed('peopledetailpage',arguments: {'peopleid':action.payload[0],'profilePath':action.payload[1],'profileName':action.payload[2]});
  }
