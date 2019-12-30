import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/customwidgets/keepalive_widget.dart';

import 'state.dart';

Widget buildView(
    TVListState state, Dispatch dispatch, ViewService viewService) {
  var adapter = viewService.buildAdapter();

  return keepAliveWrapper(AnimatedSwitcher(
      duration: Duration(milliseconds: 600),
      child: ListView.separated(
        key: ValueKey(state.tvcoming),
        controller: state.tvController,
        separatorBuilder: (_, index) => Divider(),
        itemBuilder: adapter.itemBuilder,
        itemCount: adapter.itemCount,
      )));
}
