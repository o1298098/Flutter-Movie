import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'action.dart';
import 'state.dart';

Effect<CastState> buildEffect() {
  return combineEffects(<Object, Effect<CastState>>{
    CastAction.action: _onAction,
    CastAction.cellTapped: _castCellTapped,
  });
}

void _onAction(Action action, Context<CastState> ctx) {}

Future _castCellTapped(Action action, Context<CastState> ctx) async {
  await Navigator.of(ctx.context).pushNamed('peopledetailpage', arguments: {
    'peopleid': action.payload[0],
    'profilePath': action.payload[1],
    'profileName': action.payload[2],
    'character': action.payload[3]
  });
}
