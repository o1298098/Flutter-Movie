import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/models/video_list.dart';
import 'package:movie/views/detail_page/page.dart';
import 'action.dart';
import 'state.dart';

Effect<MovieListState> buildEffect() {
  return combineEffects(<Object, Effect<MovieListState>>{
    MovieListAction.action: _onAction,
    MovieListAction.cellTapped: _cellTapped
  });
}

void _onAction(Action action, Context<MovieListState> ctx) {}
Future _cellTapped(Action action, Context<MovieListState> ctx) async {
  final VideoListResult _d = action.payload;
  if (_d == null) return;
  await Navigator.of(ctx.context).push(MaterialPageRoute(builder: (context) {
    return MovieDetailPage().buildPage({'id': _d.id, 'bgpic': _d.posterPath});
  }));
}
