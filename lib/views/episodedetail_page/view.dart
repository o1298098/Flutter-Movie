import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/style/themestyle.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    EpisodeDetailPageState state, Dispatch dispatch, ViewService viewService) {
  var adapter = viewService.buildAdapter();
  var d = state.episode;
  return Builder(builder: (context) {
    final MediaQueryData _mediaQuery = MediaQuery.of(context);
    final ThemeData _theme = _mediaQuery.platformBrightness == Brightness.light
        ? ThemeStyle.lightTheme
        : ThemeStyle.darkTheme;
    return Scaffold(
      backgroundColor: _theme.backgroundColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: _theme.backgroundColor,
        brightness: _theme.brightness,
        iconTheme: _theme.iconTheme,
        title: Text(d.name, style: _theme.textTheme.body1),
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
