import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'action.dart';
import 'state.dart';

Effect<SettingPageState> buildEffect() {
  return combineEffects(<Object, Effect<SettingPageState>>{
    SettingPageAction.action: _onAction,
    SettingPageAction.adultCellTapped: _adultCellTapped,
    SettingPageAction.cleanCached: _cleanCached,
    Lifecycle.initState: _onInit,
    Lifecycle.build: _onBuild,
    Lifecycle.dispose: _onDispose,
  });
}

void _onAction(Action action, Context<SettingPageState> ctx) {}

Future<void> _onInit(Action action, Context<SettingPageState> ctx) async {
  Object ticker = ctx.stfState;
  ctx.state.pageAnimation = AnimationController(
      vsync: ticker,
      duration: Duration(milliseconds: 800),
      reverseDuration: Duration(milliseconds: 300));
  ctx.state.userEditAnimation =
      AnimationController(vsync: ticker, duration: Duration(milliseconds: 600));
  _getCachedSize(ctx);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  final _adultItem = prefs.getBool('adultItems');
  if (_adultItem != null) if (_adultItem != ctx.state.adultSwitchValue)
    ctx.dispatch(SettingPageActionCreator.adultValueUpadte(_adultItem));
}

void _cleanCached(Action action, Context<SettingPageState> ctx) async {
  await DefaultCacheManager().emptyCache();
  _getCachedSize(ctx);
}

void _onDispose(Action action, Context<SettingPageState> ctx) {
  ctx.state.pageAnimation?.dispose();
  ctx.state.userEditAnimation?.dispose();
}

void _onBuild(Action action, Context<SettingPageState> ctx) {
  ctx.state.pageAnimation.forward();
}

void _adultCellTapped(Action action, Context<SettingPageState> ctx) async {
  final _b = ctx.state.adultSwitchValue ?? false;
  ctx.dispatch(SettingPageActionCreator.adultValueUpadte(!_b));
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('adultItems', !_b);
}

void _getCachedSize(Context<SettingPageState> ctx) async {
  final directory = Directory(await DefaultCacheManager().getFilePath());
  if (directory.existsSync()) {
    FileStat fileStat = directory.statSync();
    ctx.dispatch(
        SettingPageActionCreator.cacheSizeUpdate(fileStat.size / 1024.0));
  }
}
