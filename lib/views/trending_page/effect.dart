import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:movie/actions/apihelper.dart';
import 'package:movie/models/enums/time_window.dart';
import 'package:movie/models/sortcondition.dart';
import 'action.dart';
import 'state.dart';

Effect<TrendingPageState> buildEffect() {
  return combineEffects(<Object, Effect<TrendingPageState>>{
    TrendingPageAction.action: _onAction,
    TrendingPageAction.showFilter: _showFilter,
    TrendingPageAction.mediaTypeChanged: _mediaTypeChanged,
    TrendingPageAction.dateChanged: _dateChanged,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
  });
}

void _onAction(Action action, Context<TrendingPageState> ctx) {}

Future _onInit(Action action, Context<TrendingPageState> ctx) async {
  final Object _ticker = ctx.stfState;
  ctx.state.animationController = AnimationController(
      vsync: _ticker, duration: Duration(milliseconds: 400));

  ctx.state.controller = ScrollController()
    ..addListener(() {
      if (!ctx.state.animationController.isAnimating) {
        if (ctx.state.animationController.value == 1.0)
          ctx.state.animationController.reverse();
      }
    });
}

Future _onDispose(Action action, Context<TrendingPageState> ctx) async {
  ctx.state.controller.dispose();
  ctx.state.animationController.dispose();
}

Future _showFilter(Action action, Context<TrendingPageState> ctx) async {
  await ctx.state.controller.animateTo(0.0,
      duration: Duration(milliseconds: 300), curve: Curves.ease);
  if (!ctx.state.animationController.isAnimating) {
    if (ctx.state.animationController.value == 0.0)
      ctx.state.animationController.forward();
    else
      ctx.state.animationController.reverse();
  }
}

Future _mediaTypeChanged(Action action, Context<TrendingPageState> ctx) async {
  await ctx.state.animationController.reverse();
  final SortCondition model = action.payload;
  var _mt = ctx.state.mediaTypes;
  if (model.value != ctx.state.selectMediaType) {
    ctx.state.selectMediaType = model.value;
    int index = _mt.indexOf(model);
    _mt.forEach((f) {
      f.isSelected = false;
    });
    _mt[index].isSelected = true;
    _loadData(action, ctx);
  }
}

Future _dateChanged(Action action, Context<TrendingPageState> ctx) async {
  await ctx.state.animationController.reverse();
  final bool _b = action.payload ?? true;
  if (_b != ctx.state.isToday) {
    ctx.state.isToday = _b;
    _loadData(action, ctx);
  }
}

Future _loadData(Action action, Context<TrendingPageState> ctx) async {
  var r = await ApiHelper.getTrending(ctx.state.selectMediaType,
      ctx.state.isToday ? TimeWindow.day : TimeWindow.week);
  if (r != null) ctx.dispatch(TrendingPageActionCreator.updateList(r));
}
