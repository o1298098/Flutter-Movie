import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'action.dart';
import 'state.dart';

Effect<StartPageState> buildEffect() {
  return combineEffects(<Object, Effect<StartPageState>>{
    StartPageAction.action: _onAction,
    StartPageAction.onStart: _onStart,
    Lifecycle.build: _onBuild,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
  });
}

void _onAction(Action action, Context<StartPageState> ctx) {}
void _onInit(Action action, Context<StartPageState> ctx) async {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  _firebaseMessaging.requestNotificationPermissions();
  _firebaseMessaging.configure();
  _firebaseMessaging.autoInitEnabled();
  ctx.state.pageController = PageController();
  SharedPreferences.getInstance().then((_p) async {
    final _isFirst = _p.getBool('firstStart') ?? true;
    if (!_isFirst)
      await _pushToMainPage(ctx.context);
    else
      ctx.dispatch(StartPageActionCreator.setIsFirst(_isFirst));
  });
}

void _onDispose(Action action, Context<StartPageState> ctx) {
  ctx.state.pageController.dispose();
}

void _onBuild(Action action, Context<StartPageState> ctx) {
  // Future.delayed(Duration(milliseconds: 0), () => _pushToMainPage(ctx.context));
}
void _onStart(Action action, Context<StartPageState> ctx) async {
  SharedPreferences.getInstance().then((_p) {
    _p.setBool('firstStart', false);
  });
  await _pushToMainPage(ctx.context);
}

Future _pushToMainPage(BuildContext context) async {
  await Navigator.of(context).pushReplacement(PageRouteBuilder(
      pageBuilder: (_, __, ___) {
        return Routes.routes.buildPage('mainpage', {
          'pages': List<Widget>.unmodifiable([
            Routes.routes.buildPage('homePage', null),
            Routes.routes.buildPage('discoverPage', null),
            Routes.routes.buildPage('comingPage', null),
            Routes.routes.buildPage('testAccountPage', null)
          ])
        });
      },
      settings: RouteSettings(name: 'mainpage')));
}
