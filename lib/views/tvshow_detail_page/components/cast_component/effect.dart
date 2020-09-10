import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/models/credits_model.dart';
import 'action.dart';
import 'state.dart';

Effect<CastState> buildEffect() {
  return combineEffects(<Object, Effect<CastState>>{
    CastAction.action: _onAction,
    CastAction.castCellTapped: _castCellTapped,
  });
}

void _onAction(Action action, Context<CastState> ctx) {}

void _castCellTapped(Action action, Context<CastState> ctx) async {
  final CastData _cast = action.payload;
  if (_cast == null) return;
  await Navigator.of(ctx.context).pushNamed('peopledetailpage', arguments: {
    'peopleid': _cast.id,
    'profilePath': _cast.profilePath,
    'profileName': _cast.name
  });
}
