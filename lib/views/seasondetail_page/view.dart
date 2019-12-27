import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/style/themestyle.dart';

import 'state.dart';

Widget buildView(
    SeasonDetailPageState state, Dispatch dispatch, ViewService viewService) {
  var adapter = viewService.buildAdapter();
  return Builder(builder: (context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Scaffold(
      backgroundColor: _theme.backgroundColor,
      appBar: AppBar(
        brightness: _theme.brightness,
        iconTheme: _theme.iconTheme,
        backgroundColor: _theme.backgroundColor,
        elevation: 0.0,
        centerTitle: false,
        title: Text(
          I18n.of(viewService.context).seasonDetail,
          style: _theme.textTheme.body1,
        ),
      ),
      body: ListView.builder(
        itemBuilder: adapter.itemBuilder,
        itemCount: adapter.itemCount,
      ),
    );
  });
}
