import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart' hide Action;
import 'action.dart';
import 'state.dart';

Effect<CreditsState> buildEffect() {
  return combineEffects(<Object, Effect<CreditsState>>{
    CreditsAction.action: _onAction,
    CreditsAction.castTapped:_onCastCellTapped
  });
}

void _onAction(Action action, Context<CreditsState> ctx) {
}

Future _onCastCellTapped(Action action, Context<CreditsState> ctx) async{
    await Navigator.of(ctx.context).pushNamed('peopledetailpage',arguments: {'peopleid':action.payload[0],'profilePath':action.payload[1],'profileName':action.payload[2],'character':action.payload[3]});
  }
