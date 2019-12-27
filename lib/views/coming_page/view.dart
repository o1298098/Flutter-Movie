import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/style/themestyle.dart';

import 'action.dart';
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
            title: Container(
                child: TabBar(
              onTap: (i) {
                if (i == 0)
                  dispatch(ComingPageActionCreator.onFilterChanged(true));
                else
                  dispatch(ComingPageActionCreator.onFilterChanged(false));
              },
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: _theme.tabBarTheme.labelColor,
              labelColor: _theme.tabBarTheme.labelColor,
              unselectedLabelColor: _theme.tabBarTheme.unselectedLabelColor,
              labelStyle: TextStyle(
                  fontSize: Adapt.px(35), fontWeight: FontWeight.bold),
              unselectedLabelStyle: TextStyle(color: Colors.grey),
              tabs: <Widget>[
                Tab(
                  text: I18n.of(viewService.context).movies,
                ),
                Tab(
                  text: I18n.of(viewService.context).tvShows,
                )
              ],
            )),
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
