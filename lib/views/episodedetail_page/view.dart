import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/style/themestyle.dart';

import 'state.dart';

Widget buildView(
    EpisodeDetailPageState state, Dispatch dispatch, ViewService viewService) {
  final adapter = viewService.buildAdapter();
  final d = state.episode;
  return Builder(builder: (context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Scaffold(
      backgroundColor: _theme.backgroundColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: _theme.backgroundColor,
        brightness: _theme.brightness,
        iconTheme: _theme.iconTheme,
        title: Text(d.name, style: _theme.textTheme.bodyText1),
      ),
      body: Container(
          alignment: Alignment.topLeft,
          height: Adapt.screenH(),
          child: ListView.builder(
            itemBuilder: adapter.itemBuilder,
            itemCount: adapter.itemCount,
          )),
    );
  });
}
