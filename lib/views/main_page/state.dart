import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/globalbasestate/state.dart';
import 'package:movie/models/app_user.dart';

class MainPageState implements GlobalBaseState, Cloneable<MainPageState> {
  int selectedIndex = 0;
  List<Widget> pages;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  MainPageState clone() {
    return MainPageState()
      ..pages = pages
      ..selectedIndex = selectedIndex
      ..scaffoldKey = scaffoldKey
      ..locale = locale;
  }

  @override
  Locale locale;

  @override
  Color themeColor;

  @override
  AppUser user;
}

MainPageState initState(Map<String, dynamic> args) {
  return MainPageState()..pages = args['pages'];
}
