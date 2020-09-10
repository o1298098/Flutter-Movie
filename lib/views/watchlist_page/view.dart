import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'state.dart';

Widget buildView(
    WatchlistPageState state, Dispatch dispatch, ViewService viewService) {
  return Builder(
    builder: (context) {
      Widget _buildBody() {
        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              viewService.buildComponent('header'),
              viewService.buildComponent('swiper'),
              viewService.buildComponent('info'),
            ],
          ),
        );
      }

      return Scaffold(body: _buildBody());
    },
  );
}
