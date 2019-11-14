import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/actions/base_api.dart';
import 'package:movie/models/enums/media_type.dart';
import 'package:movie/models/sortcondition.dart';
import 'package:movie/views/detail_page/page.dart';
import 'package:movie/views/tvdetail_page/page.dart';
import 'action.dart';
import 'state.dart';

Effect<AllStreamLinkPageState> buildEffect() {
  return combineEffects(<Object, Effect<AllStreamLinkPageState>>{
    AllStreamLinkPageAction.action: _onAction,
    AllStreamLinkPageAction.search: _onSearch,
    AllStreamLinkPageAction.gridCellTapped: _onCellTapped,
    AllStreamLinkPageAction.sortChanged: _sortChanged,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose
  });
}

void _onAction(Action action, Context<AllStreamLinkPageState> ctx) {}

void _onInit(Action action, Context<AllStreamLinkPageState> ctx) {
  final Object ticker = ctx.stfState;
  ctx.state.animationController =
      AnimationController(vsync: ticker, duration: Duration(milliseconds: 300));
  ctx.state.scrollController = ScrollController()
    ..addListener(() {
      if (ctx.state.animationController.value != 0 &&
          !ctx.state.animationController.isAnimating)
        ctx.state.animationController.reverse();
      bool bottom = ctx.state.scrollController.position.pixels ==
          ctx.state.scrollController.position.maxScrollExtent;
      if (bottom) _loadMore(ctx);
    });
  _initlist(ctx);
}

void _onDispose(Action action, Context<AllStreamLinkPageState> ctx) {
  ctx.state.animationController.dispose();
  ctx.state.scrollController.dispose();
}

Future _sortChanged(Action action, Context<AllStreamLinkPageState> ctx) async {
  await ctx.state.animationController.reverse();
  final SortCondition model = action.payload;
  if (model.value[0] != ctx.state.orderBy || model.value[1] != ctx.state.desc) {
    ctx.state.orderBy = model.value[0];
    ctx.state.desc = model.value[1];
    int index = ctx.state.sortTypes.indexOf(model);
    ctx.state.sortTypes.forEach((f) {
      f.isSelected = false;
    });
    ctx.state.sortTypes[index].isSelected = true;
    _initlist(ctx);
  }
}

void _loadMore(Context<AllStreamLinkPageState> ctx) async {
  BaseApi.getMovies(page: ctx.state.streamList.page + 1).then((d) {
    if (d != null) ctx.dispatch(AllStreamLinkPageActionCreator.loadMore(d));
  });
}

void _initlist(Context<AllStreamLinkPageState> ctx) {
  BaseApi.getMovies().then((d) {
    if (d != null)
      ctx.dispatch(AllStreamLinkPageActionCreator.initStreamList(d));
  });
}

void _onSearch(Action action, Context<AllStreamLinkPageState> ctx) {
  final String query = action.payload ?? '';
  if (query != '')
    BaseApi.searchMovies(query).then((d) {
      if (d != null)
        ctx.dispatch(AllStreamLinkPageActionCreator.initStreamList(d));
    });
}

Future _onCellTapped(Action action, Context<AllStreamLinkPageState> ctx) async {
  final MediaType type = action.payload[4];
  final int id = action.payload[0];
  final String bgpic = action.payload[1];
  final String title = action.payload[2];
  final String posterpic = action.payload[3];
  final String pagename =
      type == MediaType.movie ? 'detailpage' : 'tvdetailpage';
  var data = {
    type == MediaType.movie ? 'id' : 'tvid': id,
    'bgpic': type == MediaType.movie ? posterpic : bgpic,
    type == MediaType.movie ? 'title' : 'name': title,
    'posterpic': posterpic
  };
  Page page = type == MediaType.movie ? MovieDetailPage() : TVDetailPage();
  await Navigator.of(ctx.context).push(PageRouteBuilder(
      settings: RouteSettings(name: pagename),
      pageBuilder: (context, animation, secAnimation) {
        return FadeTransition(
          opacity: animation,
          child: page.buildPage(data),
        );
      }));
  //await Navigator.of(ctx.context).pushNamed(pagename, arguments: data);
}
