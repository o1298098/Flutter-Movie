import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/views/coming_page/action.dart';

import 'state.dart';

Widget buildView(TabState state, Dispatch dispatch, ViewService viewService) {
  final ThemeData _theme = ThemeStyle.getTheme(viewService.context);
  return Container(
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
    labelStyle: TextStyle(fontSize: Adapt.px(35), fontWeight: FontWeight.bold),
    unselectedLabelStyle: TextStyle(color: const Color(0xFF9E9E9E)),
    tabs: <Widget>[
      Tab(
        text: I18n.of(viewService.context).movies,
      ),
      Tab(
        text: I18n.of(viewService.context).tvShows,
      )
    ],
  ));
}
