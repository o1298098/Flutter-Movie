import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/widgets/sliverappbar_delegate.dart';
import 'package:movie/style/themestyle.dart';

import 'state.dart';

Widget buildView(
    TabbarState state, Dispatch dispatch, ViewService viewService) {
  final ThemeData _theme = ThemeStyle.getTheme(viewService.context);
  final _season = state.seasons.reversed.toList();

  return SliverPersistentHeader(
    pinned: true,
    delegate: SliverAppBarDelegate(
        maxHeight: Adapt.px(100),
        minHeight: Adapt.px(100),
        child: Container(
            color: _theme.backgroundColor,
            child: TabBar(
              isScrollable: true,
              controller: state.tabController,
              labelColor: _theme.tabBarTheme.labelColor,
              indicatorColor: Colors.transparent,
              unselectedLabelColor: Colors.grey,
              labelStyle: TextStyle(
                  fontSize: Adapt.px(35), fontWeight: FontWeight.bold),
              unselectedLabelStyle: TextStyle(
                  fontSize: Adapt.px(35), fontWeight: FontWeight.bold),
              tabs: _season.map((f) {
                return Tab(text: f.name);
              }).toList(),
            ))),
  );
}
