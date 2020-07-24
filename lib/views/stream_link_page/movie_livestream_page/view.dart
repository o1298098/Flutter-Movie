import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/style/themestyle.dart';

import 'state.dart';

Widget buildView(
    MovieLiveStreamState state, Dispatch dispatch, ViewService viewService) {
  return Builder(
    builder: (context) {
      final _theme = ThemeStyle.getTheme(context);

      return Scaffold(
        backgroundColor: _theme.backgroundColor,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: _theme.brightness == Brightness.light
              ? SystemUiOverlayStyle.dark
              : SystemUiOverlayStyle.light,
          child: Stack(
            children: [
              Container(
                child: ListView(
                  controller: state.scrollController,
                  padding: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
                  children: [
                    SizedBox(height: Adapt.px(30) + Adapt.padTopH()),
                    viewService.buildComponent('player'),
                    viewService.buildComponent('header'),
                    viewService.buildComponent('recommendation'),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
              Container(
                color: _theme.backgroundColor,
                height: Adapt.padTopH(),
              ),
              viewService.buildComponent('bottomPanel'),
            ],
          ),
        ),
      );
    },
  );
}
