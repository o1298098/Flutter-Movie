import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/models/item.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'action.dart';
import 'state.dart';

Effect<AccountState> buildEffect() {
  return combineEffects(<Object, Effect<AccountState>>{
    AccountAction.action: _onAction,
    AccountAction.navigatorPush: _navigatorPush,
    Lifecycle.initState: _onInit,
  });
}

void _onAction(Action action, Context<AccountState> ctx) {}

void _navigatorPush(Action action, Context<AccountState> ctx) async {
  if (ctx.state.user?.firebaseUser == null)
    await _onLogin(action, ctx);
  else {
    String routerName = action.payload[0];
    Object data = action.payload[1];
    await Navigator.of(ctx.context).pushNamed(routerName, arguments: data);
  }
}

Future _onLogin(Action action, Context<AccountState> ctx) async {
  await Navigator.of(ctx.context).pushNamed('loginpage');
}

void _onInit(Action action, Context<AccountState> ctx) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final _adultItem = prefs.getBool('adultItems');
  if (_adultItem != null) ctx.state.settingsState.adultContent = _adultItem;
  final _enableNotifications = prefs.getBool('enableNotifications');
  if (_enableNotifications != null)
    ctx.state.settingsState.enableNotifications = _enableNotifications;
  final _packageInfo = await PackageInfo.fromPlatform();
  ctx.state.settingsState.version = _packageInfo?.version ?? '-';
  final _appLanguage = prefs.getString('appLanguage');
  if (_appLanguage != null)
    ctx.state.settingsState.appLanguage = Item(_appLanguage);
}
