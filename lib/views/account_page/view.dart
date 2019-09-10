import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    AccountPageState state, Dispatch dispatch, ViewService viewService) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
      .copyWith(statusBarBrightness: Brightness.light));

  return Scaffold(
    body: AnimatedSwitcher(
        switchOutCurve: Curves.easeOut,
        switchInCurve: Curves.easeIn,
        duration: Duration(milliseconds: 300),
        child: viewService.buildComponent('theme${state.themeIndex + 1}')),
  );
}
