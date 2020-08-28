import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/models/models.dart';
import 'action.dart';
import 'state.dart';

Effect<StreamLinkFilterState> buildEffect() {
  return combineEffects(<Object, Effect<StreamLinkFilterState>>{
    StreamLinkFilterAction.action: _onAction,
    StreamLinkFilterAction.selectedLinkTap: _selectedLinkTap,
  });
}

void _onAction(Action action, Context<StreamLinkFilterState> ctx) {}

void _selectedLinkTap(Action action, Context<StreamLinkFilterState> ctx) {
  final MovieStreamLink _link = action.payload;
  if (_link == null) return;
  ctx.dispatch(StreamLinkFilterActionCreator.setSelectedLink(_link));
  Navigator.of(ctx.context).pop();
}
