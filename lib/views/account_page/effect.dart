import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/customwidgets/custom_stfstate.dart';
import 'package:movie/globalbasestate/action.dart';
import 'package:movie/globalbasestate/store.dart';
import 'package:movie/views/setting_page/page.dart';
import 'action.dart';
import 'state.dart';

Effect<AccountPageState> buildEffect() {
  return combineEffects(<Object, Effect<AccountPageState>>{
    Lifecycle.initState: _onInit,
    Lifecycle.build: _onBuild,
    Lifecycle.dispose: _onDispose,
    AccountPageAction.action: _onAction,
    AccountPageAction.login: _onLogin,
    AccountPageAction.logout: _onLogout,
    AccountPageAction.navigatorPush: _navigatorPush,
    AccountPageAction.settingCellTapped: _settingCellTapped,
  });
}

final FirebaseAuth _auth = FirebaseAuth.instance;
void _onAction(Action action, Context<AccountPageState> ctx) {}

Future _onLogin(Action action, Context<AccountPageState> ctx) async {
  var r = (await Navigator.of(ctx.context).pushNamed('loginpage')) as Map;
  if (r == null) return;
  if (r['s'] == true) {
    String name = r['name'];
    String avatar = ctx.state.user?.photoUrl;
    bool islogin = ctx.state.user != null;
    ctx.dispatch(AccountPageActionCreator.onInit(name, avatar, islogin));
  }
}

Future _onInit(Action action, Context<AccountPageState> ctx) async {
  if (ctx.state.animationController == null) {
    final CustomstfState ticker = ctx.stfState as CustomstfState;
    ctx.state.animationController = AnimationController(
        vsync: ticker, duration: Duration(milliseconds: 1000));
  }
  //final FirebaseUser currentUser = await _auth.currentUser();
  String name = ctx.state.user?.displayName;
  String avatar = ctx.state.user?.photoUrl;
  bool islogin = ctx.state.user != null;
  ctx.dispatch(AccountPageActionCreator.onInit(name, avatar, islogin));
}

void _onBuild(Action action, Context<AccountPageState> ctx) {
  ctx.state.animationController.forward();
}

void _onDispose(Action action, Context<AccountPageState> ctx) {
  ctx.state.animationController.dispose();
}

Future _onLogout(Action action, Context<AccountPageState> ctx) async {
  //var q = await ApiHelper.deleteSession();
  //if (q) await _onInit(action, ctx);

  final FirebaseUser currentUser = await _auth.currentUser();
  if (currentUser != null) {
    try {
      _auth.signOut();
      GlobalStore.store.dispatch(GlobalActionCreator.setUser(null));
    } on Exception catch (_) {}
    await _onInit(action, ctx);
  }
}

Future _navigatorPush(Action action, Context<AccountPageState> ctx) async {
  if (!ctx.state.islogin)
    await _onLogin(action, ctx);
  else {
    String routerName = action.payload[0];
    Object data = action.payload[1];
    await Navigator.of(ctx.context).pushNamed(routerName, arguments: data);
  }
}

void _settingCellTapped(Action action, Context<AccountPageState> ctx) async {
  Navigator.of(ctx.context).push(PageRouteBuilder(pageBuilder: (_, __, ___) {
    return SettingPage().buildPage(null);
  }));
}
