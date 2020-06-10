import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/views/discover_page/action.dart';
import 'action.dart';
import 'state.dart';

Effect<FilterState> buildEffect() {
  return combineEffects(<Object, Effect<FilterState>>{
    FilterAction.action: _onAction,
    FilterAction.genresChanged: _genresChanged,
    FilterAction.votefilterChange: _votefilterChange,
    FilterAction.applyFilter: _applyFilter,
    Lifecycle.initState: _onInit,
  });
}

void _onAction(Action action, Context<FilterState> ctx) {}

void _genresChanged(Action action, Context<FilterState> ctx) async {
  final _genre = action.payload;
  ctx.state.currentGenres.forEach((e) {
    if (e == _genre) e.isSelected = !e.isSelected;
  });
  ctx.dispatch(FilterActionCreator.updateGenres(ctx.state.currentGenres));
}

void _votefilterChange(Action action, Context<FilterState> ctx) {
  final double _lvote = action.payload[0] ?? 0.0;
  final double _rvote = action.payload[1] ?? 10.0;
  ctx.state.lVote = _lvote;
  ctx.state.rVote = _rvote;
}

void _applyFilter(Action action, Context<FilterState> ctx) {
  ctx.dispatch(DiscoverPageActionCreator.applyFilter());
  Navigator.of(ctx.context).pop();
}

void _onInit(Action action, Context<FilterState> ctx) async {
  ctx.state.currentGenres =
      ctx.state.isMovie ? ctx.state.movieGenres : ctx.state.tvGenres;
}
