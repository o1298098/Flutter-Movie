import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart' hide Action;
import 'package:movie/actions/apihelper.dart';
import 'package:movie/models/videolist.dart';
import 'action.dart';
import 'state.dart';

Effect<ListDetailPageState> buildEffect() {
  return combineEffects(<Object, Effect<ListDetailPageState>>{
    Lifecycle.initState: _onInit,
    ListDetailPageAction.action: _onAction,
    ListDetailPageAction.cellTapped: _cellTapped,
  });
}

void _onAction(Action action, Context<ListDetailPageState> ctx) {}

Future _onInit(Action action, Context<ListDetailPageState> ctx) async {
  ctx.state.scrollController = ScrollController()
    ..addListener(() async {
      bool isBottom = ctx.state.scrollController.position.pixels ==
          ctx.state.scrollController.position.maxScrollExtent;
      if (isBottom) {
        if (ctx.state.listDetailModel.id != null) {
          int page = ctx.state.listDetailModel.page + 1;
          if (page <= ctx.state.listDetailModel.totalPages) {
            var r =await ApiHelper.getListDetailV4(ctx.state.listId, page: page);
            if (r != null)
              ctx.dispatch(ListDetailPageActionCreator.loadMore(r));
          }
        }
      }
    });
  if (ctx.state.listId != null) {
    var r = await ApiHelper.getListDetailV4(ctx.state.listId);
    if (r != null) ctx.dispatch(ListDetailPageActionCreator.setListDetail(r));
  }
}

Future _cellTapped(Action action, Context<ListDetailPageState> ctx) async {
  VideoListResult d = action.payload;
  if (d != null) {
    if (d.mediaType == 'movie')
      await Navigator.of(ctx.context).pushNamed('moviedetailpage', arguments: {
        'movieid': d.id,
        'bgpic': d.backdrop_path,
        'title': d.title,
        'posterpic': d.poster_path
      });
    else
      await Navigator.of(ctx.context).pushNamed('tvdetailpage', arguments: {
        'tvid': d.id,
        'bgpic': d.backdrop_path,
        'name': d.name,
        'posterpic': d.poster_path
      });
  }
}
