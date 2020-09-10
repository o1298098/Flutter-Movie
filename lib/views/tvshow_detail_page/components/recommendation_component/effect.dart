import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/models/video_list.dart';
import 'action.dart';
import 'state.dart';

Effect<RecommendationState> buildEffect() {
  return combineEffects(<Object, Effect<RecommendationState>>{
    RecommendationAction.action: _onAction,
    RecommendationAction.cellTapped: _cellTapped,
  });
}

void _onAction(Action action, Context<RecommendationState> ctx) {}
void _cellTapped(Action action, Context<RecommendationState> ctx) async {
  final VideoListResult _data = action.payload;
  if (_data == null) return;
  await Navigator.of(ctx.context).pushNamed('tvShowDetailPage',
      arguments: {'id': _data.id, 'bgpic': _data.backdropPath});
}
