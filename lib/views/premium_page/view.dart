import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'state.dart';

Widget buildView(
    PremiumPageState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    body: state.user.isPremium
        ? viewService.buildComponent('info')
        : viewService.buildComponent('plan'),
  );
}
