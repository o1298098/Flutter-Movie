import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:movie/models/notification_model.dart';
import 'package:movie/views/detail_page/page.dart';
import 'package:movie/views/tvshow_detail_page/page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'action.dart';
import 'state.dart';

Effect<NotificationState> buildEffect() {
  return combineEffects(<Object, Effect<NotificationState>>{
    NotificationAction.action: _onAction,
    NotificationAction.cellTapped: _cellTapped,
    Lifecycle.initState: _onInit,
  });
}

void _onAction(Action action, Context<NotificationState> ctx) {}

void _onInit(Action action, Context<NotificationState> ctx) async {
  final _preferences = await SharedPreferences.getInstance();
  NotificationList _list;
  if (_preferences.containsKey('notifications')) {
    final String _notifications = _preferences.getString('notifications');
    _list = NotificationList(_notifications);
  }
  if (_list != null)
    ctx.dispatch(NotificationActionCreator.setNotifications(_list));
}

void _cellTapped(Action action, Context<NotificationState> ctx) async {
  final NotificationModel _model = action.payload;
  if (_model == null) return;
  for (var item in ctx.state.notificationList.notifications) {
    if (item == _model && !item.read) {
      item.read = true;
    }
  }
  final _preferences = await SharedPreferences.getInstance();
  _preferences.setString(
      'notifications', ctx.state.notificationList.toString());
  ctx.dispatch(
      NotificationActionCreator.setNotifications(ctx.state.notificationList));

  var data = {
    'id': int.parse(_model.id.toString()),
    'name': _model.name,
  };
  Page page = _model.type == 'movie' ? MovieDetailPage() : TvShowDetailPage();
  await Navigator.of(ctx.context)
      .push(MaterialPageRoute(builder: (context) => page.buildPage(data)));
}
