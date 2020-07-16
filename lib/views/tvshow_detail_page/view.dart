import 'dart:ui';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/style/themestyle.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    TvShowDetailState state, Dispatch dispatch, ViewService viewService) {
  return Builder(
    builder: (context) {
      final _theme = ThemeStyle.getTheme(context);
      return Scaffold(
        backgroundColor: _theme.backgroundColor,
        appBar: AppBar(
          iconTheme: _theme.iconTheme,
          elevation: 0.0,
          backgroundColor: _theme.backgroundColor,
          brightness: _theme.brightness,
          title: Text(
            state?.tvDetailModel?.name ?? '',
            style:TextStyle(color: _theme.textTheme.bodyText1.color),
          ),
          actions: [
            IconButton(
                icon:const Icon(Icons.more_vert),
                onPressed: () => dispatch(TvShowDetailActionCreator.openMenu()))
          ],
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(vertical: Adapt.px(30)),
          physics: BouncingScrollPhysics(),
          children: [
            viewService.buildComponent('swiper'),
            viewService.buildComponent('title'),
            viewService.buildComponent('cast'),
            viewService.buildComponent('season'),
            viewService.buildComponent('lastEpisode'),
            viewService.buildComponent('keyword'),
            viewService.buildComponent('recommendation'),
          ],
        ),
      );
    },
  );
}
