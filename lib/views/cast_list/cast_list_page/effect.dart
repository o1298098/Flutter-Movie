import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/actions/api/graphql_client.dart';
import 'package:movie/models/base_api_model/base_cast_list.dart';
import 'action.dart';
import 'components/cast_list_create.dart';
import 'state.dart';

Effect<CastListState> buildEffect() {
  return combineEffects(<Object, Effect<CastListState>>{
    CastListAction.action: _onAction,
    CastListAction.addCastList: _addCastList,
    CastListAction.onCastListTap: _onCastListTap,
    CastListAction.onCastListEdit: _onCastListEdit,
    Lifecycle.initState: _onInit,
  });
}

void _onAction(Action action, Context<CastListState> ctx) {}

void _onInit(Action action, Context<CastListState> ctx) async {
  if (ctx.state.user.firebaseUser != null) {
    var _result = BaseGraphQLClient.instance
        .castListSubscription(ctx.state.user.firebaseUser.uid);
    ctx.dispatch(CastListActionCreator.setCastList(_result));
  }
}

void _addCastList(Action action, Context<CastListState> ctx) async {
  await Navigator.of(ctx.context)
      .push(MaterialPageRoute(builder: (_) => CastListCreate()));
}

void _onCastListTap(Action action, Context<CastListState> ctx) async {
  final BaseCastList _list = action.payload;
  if (_list == null) return;
  await Navigator.of(ctx.context)
      .pushNamed('castListDetailPage', arguments: {'castList': _list});
}

void _onCastListEdit(Action action, Context<CastListState> ctx) async {
  final BaseCastList _list = action.payload;
  if (_list == null) return;
  await Navigator.of(ctx.context)
      .push(MaterialPageRoute(builder: (_) => CastListCreate(data: _list)));
}
