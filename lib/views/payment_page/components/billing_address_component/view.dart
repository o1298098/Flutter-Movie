import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/style/themestyle.dart';

import 'state.dart';

Widget buildView(
    BillingAddressState state, Dispatch dispatch, ViewService viewService) {
  final _theme = ThemeStyle.getTheme(viewService.context);
  return Scaffold(
    appBar: AppBar(
      backgroundColor: _theme.primaryColorDark,
      brightness: _theme.brightness,
      iconTheme: _theme.iconTheme,
      elevation: 0.0,
      title: Text('Billing Address',
          style: TextStyle(color: _theme.textTheme.bodyText1.color)),
    ),
  );
}
