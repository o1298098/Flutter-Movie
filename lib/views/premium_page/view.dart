import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie/style/themestyle.dart';
import 'state.dart';

Widget buildView(
    PremiumPageState state, Dispatch dispatch, ViewService viewService) {
  return Builder(
    builder: (context) {
      final _theme = ThemeStyle.getTheme(context);
      return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: _theme.brightness == Brightness.light
              ? SystemUiOverlayStyle.dark
              : SystemUiOverlayStyle.light,
          child: state.user.isPremium
              ? viewService.buildComponent('info')
              : viewService.buildComponent('plan'),
        ),
      );
    },
  );
}
