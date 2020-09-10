import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/style/themestyle.dart';

import 'state.dart';

Widget buildView(
    ComingPageState state, Dispatch dispatch, ViewService viewService) {
  return Builder(builder: (context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            brightness: _theme.brightness,
            title: viewService.buildComponent('tab'),
            backgroundColor: _theme.backgroundColor,
            elevation: 0.0,
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              viewService.buildComponent('movielist'),
              viewService.buildComponent('tvlist'),
            ],
          )),
    );
  });
}
