import 'package:fish_redux/fish_redux.dart';
import 'package:movie/actions/api/tmdb_api.dart';
import 'package:movie/models/enums/time_window.dart';
import 'package:movie/models/sort_condition.dart';
import 'action.dart';
import 'state.dart';

Effect<FilterState> buildEffect() {
  return combineEffects(<Object, Effect<FilterState>>{
    FilterAction.action: _onAction,
    FilterAction.mediaTypeChanged: _mediaTypeChanged,
    FilterAction.dateChanged: _dateChanged,
  });
}

void _onAction(Action action, Context<FilterState> ctx) {}

Future _mediaTypeChanged(Action action, Context<FilterState> ctx) async {
  await ctx.state.animationController.reverse();
  final SortCondition model = action.payload;
  var _mt = ctx.state.mediaTypes;
  if (model.isSelected != true) {
    if (!ctx.state.refreshController.isAnimating)
      await ctx.state.refreshController.forward();
    int index = _mt.indexOf(model);
    _mt.forEach((f) {
      f.isSelected = false;
    });
    _mt[index].isSelected = true;
    ctx.dispatch(FilterActionCreator.updateMediaType(_mt, model.value));
    _loadData(ctx);
  }
}

Future _dateChanged(Action action, Context<FilterState> ctx) async {
  await ctx.state.animationController.reverse();
  final bool _b = action.payload ?? true;
  if (_b != ctx.state.isToday) {
    if (!ctx.state.refreshController.isAnimating)
      await ctx.state.refreshController.forward();
    ctx.dispatch(FilterActionCreator.updateDate(_b));
    _loadData(ctx);
  }
}

Future _loadData(Context<FilterState> ctx) async {
  final _tmdb = TMDBApi.instance;
  var r = await _tmdb.getTrending(ctx.state.selectMediaType,
      ctx.state.isToday ? TimeWindow.day : TimeWindow.week);
  if (r.success) ctx.dispatch(FilterActionCreator.updateList(r.result));
  ctx.state.refreshController.reset();
}
