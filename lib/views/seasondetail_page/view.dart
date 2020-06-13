import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/style/themestyle.dart';

import 'state.dart';

Widget buildView(
    SeasonDetailPageState state, Dispatch dispatch, ViewService viewService) {
  var adapter = viewService.buildAdapter();
  return Builder(builder: (context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            brightness: _theme.brightness,
            iconTheme: _theme.iconTheme,
            backgroundColor: _theme.backgroundColor,
            elevation: 0.0,
            centerTitle: false,
            title: Text(
              state.tvShowName ?? '',
              style: _theme.textTheme.bodyText1,
            ),
          ),
          //backgroundColor: _theme.backgroundColor,
          body: ListView.builder(
            padding: EdgeInsets.zero,
            itemBuilder: adapter.itemBuilder,
            itemCount: adapter.itemCount,
          ),
        ),
      ],
    );
  });
}
