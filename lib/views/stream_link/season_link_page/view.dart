import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/style/themestyle.dart';
import 'state.dart';

Widget buildView(
    SeasonLinkPageState state, Dispatch dispatch, ViewService viewService) {
  final _adapter = viewService.buildAdapter();
  return Builder(
    builder: (context) {
      final ThemeData _theme = ThemeStyle.getTheme(context);
      final _list = List<Widget>.filled(_adapter.itemCount, null).asMap().keys.map((k) {
        return SizedBox(
            key: Key('TabView${state.detail.seasons[k].id}'),
            child: _adapter.itemBuilder(viewService.context, k));
      }).toList();
      return Scaffold(
        backgroundColor: _theme.backgroundColor,
        body: NestedScrollView(
          controller: state.scrollController,
          headerSliverBuilder: (context, bool) {
            return [
              viewService.buildComponent('appBar'),
              viewService.buildComponent('header'),
              viewService.buildComponent('tabBar'),
            ];
          },
          body: TabBarView(controller: state.tabController, children: _list),
        ),
      );
    },
  );
}
