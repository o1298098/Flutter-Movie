import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/actions/api/base_api.dart';
import 'action.dart';
import 'state.dart';

Effect<MyListsPageState> buildEffect() {
  return combineEffects(<Object, Effect<MyListsPageState>>{
    Lifecycle.initState: _onInit,
    Lifecycle.deactivate: _onDeactivate,
    Lifecycle.dispose: _onDispose,
    MyListsPageAction.createList: _createList,
  });
}

Future _onInit(Action action, Context<MyListsPageState> ctx) async {
  final Object ticker = ctx.stfState;
  ctx.state.animationController =
      AnimationController(vsync: ticker, duration: Duration(milliseconds: 300));
  ctx.state.cellAnimationController = AnimationController(
      vsync: ticker, duration: Duration(milliseconds: 1000));
  ctx.state.scrollController = ScrollController(keepScrollOffset: false);
  if (ctx.state.user != null) {
    final _baseApi = BaseApi.instance;
    final _data = await _baseApi.getUserList(ctx.state.user.firebaseUser.uid);
    if (_data.success)
      ctx.dispatch(MyListsPageActionCreator.setList(_data.result));
  }
}

void _onDispose(Action action, Context<MyListsPageState> ctx) {
  ctx.state.cellAnimationController.stop();
  ctx.state.scrollController.dispose();
  ctx.state.animationController.dispose();
  ctx.state.cellAnimationController.dispose();
}

void _onDeactivate(Action action, Context<MyListsPageState> ctx) {
  ctx.state.cellAnimationController.stop();
  ctx.state.animationController.stop();
}

void _createList(Action action, Context<MyListsPageState> ctx) async {
  ctx.state.animationController.value = 0;
  ctx.state.cellAnimationController.reset();
  ctx.dispatch(MyListsPageActionCreator.onEdit(false));
  await Navigator.of(ctx.context)
      .pushNamed('createListPage', arguments: action.payload)
      .then((d) {
    if (d != null) {
      ctx.state.listData.data.insert(0, d);
      ctx.dispatch(MyListsPageActionCreator.setList(ctx.state.listData));
    }
  });
}
