import 'package:fish_redux/fish_redux.dart';
import 'package:movie/actions/apihelper.dart';
import 'package:movie/models/enums/time_window.dart';
import 'package:movie/models/sortcondition.dart';
import 'action.dart';
import 'state.dart';

Effect<FliterState> buildEffect() {
  return combineEffects(<Object, Effect<FliterState>>{
    FliterAction.action: _onAction,
    FliterAction.mediaTypeChanged: _mediaTypeChanged,
    FliterAction.dateChanged: _dateChanged,
  });
}

void _onAction(Action action, Context<FliterState> ctx) {}

Future _mediaTypeChanged(Action action, Context<FliterState> ctx) async {
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
    ctx.dispatch(FliterActionCreator.updateMediaType(_mt, model.value));
    _loadData(ctx);
  }
}

Future _dateChanged(Action action, Context<FliterState> ctx) async {
  await ctx.state.animationController.reverse();
  final bool _b = action.payload ?? true;
  if (_b != ctx.state.isToday) {
    if (!ctx.state.refreshController.isAnimating)
      await ctx.state.refreshController.forward();
    ctx.dispatch(FliterActionCreator.updateDate(_b));
    _loadData(ctx);
  }
}

Future _loadData(Context<FliterState> ctx) async {
  var r = await ApiHelper.getTrending(ctx.state.selectMediaType,
      ctx.state.isToday ? TimeWindow.day : TimeWindow.week);
  if (r != null) ctx.dispatch(FliterActionCreator.updateList(r));
  ctx.state.refreshController.reset();
}
