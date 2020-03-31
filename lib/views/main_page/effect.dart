import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/actions/apihelper.dart';
import 'package:movie/globalbasestate/action.dart';
import 'package:movie/globalbasestate/store.dart';
import 'package:movie/views/detail_page/page.dart';
import 'package:movie/views/tvdetail_page/page.dart';
import 'action.dart';
import 'state.dart';

Effect<MainPageState> buildEffect() {
  return combineEffects(<Object, Effect<MainPageState>>{
    MainPageAction.action: _onAction,
    Lifecycle.initState: _onInit
  });
}

void _onAction(Action action, Context<MainPageState> ctx) {}
void _onInit(Action action, Context<MainPageState> ctx) async {
  await ApiHelper.init();
  var _user = await FirebaseAuth.instance.currentUser();
  if (_user != null)
    GlobalStore.store.dispatch(GlobalActionCreator.setUser(_user));
  FirebaseMessaging().configure(
      onMessage: (_) async => print('233333'),
      onResume: (message) async {
        _push(message, ctx);
      },
      onLaunch: (message) async {
        _push(message, ctx);
      });
}

Future _push(Map<String, dynamic> message, Context<MainPageState> ctx) async {
  if (message['data'] != null) {
    final _messageData = message['data'];
    var data = {
      _messageData['type'] == 'movie' ? 'id' : 'tvid':
          int.parse(_messageData['id'].toString()),
      'bgpic': _messageData['type'] == 'movie'
          ? _messageData['posterPic']
          : _messageData['bgPic'],
      _messageData['type'] == 'movie' ? 'title' : 'name': _messageData['name'],
      'posterpic': _messageData['posterPic']
    };
    Page page =
        _messageData['type'] == 'movie' ? MovieDetailPage() : TVDetailPage();
    await Navigator.of(ctx.state.scaffoldKey.currentContext)
        .push(PageRouteBuilder(pageBuilder: (context, animation, secAnimation) {
      return FadeTransition(
        opacity: animation,
        child: page.buildPage(data),
      );
    }));
  }
}
