import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/sortcondition.dart';
import 'action.dart';
import 'state.dart';

Effect<FilterState> buildEffect() {
  return combineEffects(<Object, Effect<FilterState>>{
    FilterAction.action: _onAction,
    FilterAction.genresChanged: _genresChanged,
    Lifecycle.initState: _onInit,
  });
}

void _onAction(Action action, Context<FilterState> ctx) {}

void _genresChanged(Action action, Context<FilterState> ctx) async {
  final _genre = action.payload;
  ctx.state.currectGenres.forEach((e) {
    if (e == _genre) e.isSelected = !e.isSelected;
  });
  ctx.dispatch(FilterActionCreator.updateGenres(ctx.state.currectGenres));
}

void _onInit(Action action, Context<FilterState> ctx) async {
  ctx.state.sortTypes = [
    SortCondition(name: 'Popularity', isSelected: true, value: 'popularity'),
    SortCondition(
        name: 'Release Date', isSelected: false, value: 'release_date'),
    SortCondition(name: 'Title', isSelected: false, value: 'original_title'),
    SortCondition(name: 'Rating', isSelected: false, value: 'vote_average'),
    SortCondition(name: 'Vote Count', isSelected: false, value: 'vote_count'),
  ];
  ctx.state.selectedSort = ctx.state.sortTypes[0];

  ctx.state.currectGenres =
      ctx.state.isMovie ? ctx.state.movieGenres : ctx.state.tvGenres;
}
