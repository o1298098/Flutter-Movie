import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/models/models.dart';
import 'action.dart';
import 'state.dart';

Effect<SwiperState> buildEffect() {
  return combineEffects(<Object, Effect<SwiperState>>{
    SwiperAction.action: _onAction,
    SwiperAction.cellTapped: _cellTapped,
  });
}

void _onAction(Action action, Context<SwiperState> ctx) {}

void _cellTapped(Action action, Context<SwiperState> ctx) async {
  final UserMedia _media = action.payload;
  if (_media == null) return;
  final int _id = _media.mediaId;
  final String title = _media.name;
  final String posterpic = _media.photoUrl;
  final String _pageName =
      _media.mediaType == 'movie' ? 'detailpage' : 'tvShowDetailPage';
  var _data = {
    'id': _id,
    'bgpic': posterpic,
    'name': title,
    'posterpic': posterpic
  };
  await Navigator.of(ctx.context).pushNamed(_pageName, arguments: _data);
}
