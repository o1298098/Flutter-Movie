import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/actions/api/base_api.dart';
import 'package:movie/widgets/share_card.dart';
import 'package:movie/models/base_api_model/user_list_detail.dart';
import 'package:movie/models/sort_condition.dart';
import 'action.dart';
import 'state.dart';

Effect<ListDetailPageState> buildEffect() {
  return combineEffects(<Object, Effect<ListDetailPageState>>{
    Lifecycle.initState: _onInit,
    ListDetailPageAction.action: _onAction,
    ListDetailPageAction.cellTapped: _cellTapped,
    ListDetailPageAction.sortChanged: _sortChanged,
    ListDetailPageAction.showShareCard: _showShareCard,
  });
}

void _onAction(Action action, Context<ListDetailPageState> ctx) {}
void _showShareCard(Action action, Context<ListDetailPageState> ctx) {
  showDialog(
      context: ctx.context,
      builder: (context) {
        return ShareCard(
          backgroundImage: ctx.state.listDetailModel?.backGroundUrl ?? '',
          qrValue: "https://www.themoviedb.org/list/${ctx.state.listId}",
          header: ctx.buildComponent('shareCard'),
        );
      });
}

Future _onInit(Action action, Context<ListDetailPageState> ctx) async {
  if (ctx.state.listDetailModel?.id != null) {
    final _baseApi = BaseApi.instance;
    final _detailItem =
        await _baseApi.getUserListDetailItems(ctx.state.listDetailModel?.id);
    if (_detailItem.success)
      ctx.dispatch(
          ListDetailPageActionCreator.setListDetail(_detailItem.result));
  }
}

Future _cellTapped(Action action, Context<ListDetailPageState> ctx) async {
  UserListDetail d = action.payload;
  if (d != null) {
    await Navigator.of(ctx.context).pushNamed(
        d.mediaType == 'movie' ? 'detailpage' : 'tvShowDetailPage',
        arguments: {
          'id': d.mediaid,
          'bgpic': d.photoUrl,
          'name': d.mediaName,
          'posterpic': d.photoUrl
        });
  }
}

Future _sortChanged(Action action, Context<ListDetailPageState> ctx) async {
  final SortCondition model = action.payload;
  if (model.value != ctx.state.sortType) {
    ctx.dispatch(ListDetailPageActionCreator.setSort(model));
    _loadData(action, ctx);
  }
}

Future _loadData(Action action, Context<ListDetailPageState> ctx) async {}
