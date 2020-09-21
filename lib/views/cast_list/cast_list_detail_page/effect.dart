import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/actions/api/base_api.dart';
import 'package:movie/actions/api/graphql_client.dart';
import 'package:movie/models/base_api_model/cast_list_detail.dart';
import 'package:movie/views/peopledetail_page/page.dart';
import 'package:toast/toast.dart';
import 'action.dart';
import 'state.dart';

Effect<CastListDetailState> buildEffect() {
  return combineEffects(<Object, Effect<CastListDetailState>>{
    CastListDetailAction.action: _onAction,
    CastListDetailAction.onCastTap: _onCastTap,
    CastListDetailAction.onDeleteTap: _onDeleteTap,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
  });
}

void _onAction(Action action, Context<CastListDetailState> ctx) {}

void _onInit(Action action, Context<CastListDetailState> ctx) async {
  ctx.state.scrollController = ScrollController()
    ..addListener(() async {
      bool isBottom = ctx.state.scrollController.position.pixels ==
          ctx.state.scrollController.position.maxScrollExtent;
      if (isBottom && !ctx.state.allLoaded) {
        await _onLoadMore(action, ctx);
      }
    });
  if (ctx.state.castList == null) return;
  final _result =
      await BaseApi.instance.getCastListDetail(ctx.state.castList.id);
  if (_result.success)
    ctx.dispatch(CastListDetailActionCreator.setListDetail(_result.result));
}

void _onCastTap(Action action, Context<CastListDetailState> ctx) async {
  final BaseCast _cast = action.payload;
  if (_cast == null) return;
  await Navigator.of(ctx.context)
      .push(PageRouteBuilder(pageBuilder: (context, animation, secAnimation) {
    return FadeTransition(
      opacity: animation,
      child: PeopleDetailPage().buildPage({
        'peopleid': _cast.castId,
        'profilePath': _cast.profileUrl,
        'profileName': _cast.name,
        'character': _cast.updateTime.toString()
      }),
    );
  }));
}

Future _onLoadMore(Action action, Context<CastListDetailState> ctx) async {
  ctx.dispatch(CastListDetailActionCreator.loading(true));
  final _result = await BaseApi.instance.getCastListDetail(
      ctx.state.castList.id,
      page: ctx.state.listDetail.page + 1);
  if (_result.success) {
    if (_result.result.data.length > 0)
      ctx.dispatch(CastListDetailActionCreator.setLoadMore(_result.result));
    else
      ctx.state.allLoaded = true;
  }
  ctx.dispatch(CastListDetailActionCreator.loading(false));
}

void _onDispose(Action action, Context<CastListDetailState> ctx) {
  ctx.state.scrollController?.dispose();
}

void _onDeleteTap(Action action, Context<CastListDetailState> ctx) async {
  final BaseCast _cast = action.payload;
  if (_cast == null) return;
  final _result =
      await BaseGraphQLClient.instance.deleteCast(_cast.id, ctx.state.castList);
  if (!_result.hasException) {
    ctx.dispatch(CastListDetailActionCreator.updateCastList(_cast));
  } else {
    Toast.show('Something wrong', ctx.context);
  }
}
