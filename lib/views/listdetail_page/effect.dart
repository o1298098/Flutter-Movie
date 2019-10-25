import 'dart:io';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart' hide Action;
import 'package:movie/actions/apihelper.dart';
import 'package:movie/models/enums/screenshot_type.dart';
import 'package:movie/models/sortcondition.dart';
import 'package:movie/models/videolist.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_extend/share_extend.dart';
import 'action.dart';
import 'state.dart';

Effect<ListDetailPageState> buildEffect() {
  return combineEffects(<Object, Effect<ListDetailPageState>>{
    Lifecycle.initState: _onInit,
    ListDetailPageAction.action: _onAction,
    ListDetailPageAction.cellTapped: _cellTapped,
    ListDetailPageAction.sortChanged: _sortChanged,
  });
}

void _onAction(Action action, Context<ListDetailPageState> ctx) {}

Future _onInit(Action action, Context<ListDetailPageState> ctx) async {}

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

Future _sortChanged(Action action, Context<ListDetailPageState> ctx) async {
  final SortCondition model = action.payload;
  if (model.value != ctx.state.sortType) {
    ctx.dispatch(ListDetailPageActionCreator.setSort(model));
    _loadData(action, ctx);
  }
}

Future _loadData(Action action, Context<ListDetailPageState> ctx) async {}
