import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/style/themestyle.dart';
import 'state.dart';

Widget buildView(
    MovieDetailPageState state, Dispatch dispatch, ViewService viewService) {
  return Builder(builder: (context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);

    return Scaffold(
        key: state.scaffoldkey,
        backgroundColor: _theme.backgroundColor,
        body: Stack(children: [
          CustomScrollView(
            controller: state.scrollController,
            physics: ClampingScrollPhysics(),
            slivers: <Widget>[
              viewService.buildComponent('mainInfo'),
              viewService.buildComponent('overView'),
              viewService.buildComponent('cast'),
              viewService.buildComponent('still'),
              viewService.buildComponent('keyWords'),
              viewService.buildComponent('trailer'),
              viewService.buildComponent('recommendations'),
            ],
          ),
          viewService.buildComponent('appbar')
        ]));
  });
}
