import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/style/themestyle.dart';
import 'state.dart';

Widget buildView(
    FavoritesPageState state, Dispatch dispatch, ViewService viewService) {
  return Builder(builder: (context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          viewService.buildComponent('backGround'),
          Container(
            color: _theme.backgroundColor.withAlpha(230),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: Adapt.px(100)),
                  viewService.buildComponent('header'),
                  viewService.buildComponent('swiper'),
                  Expanded(child: Container()),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            child: AppBar(
              brightness: _theme.brightness,
              titleSpacing: 0,
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              iconTheme: _theme.iconTheme,
              centerTitle: true,
              title: Text(
                'My Favorites',
                style: _theme.textTheme.bodyText1,
              ),
              actions: <Widget>[
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.sort),
                )
              ],
            ),
          )
        ],
      ),
    );
  });
}
