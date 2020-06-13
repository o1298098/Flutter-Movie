import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/widgets/keepalive_widget.dart';

import 'state.dart';

Widget buildView(
    TVListState state, Dispatch dispatch, ViewService viewService) {
  var adapter = viewService.buildAdapter();

  return keepAliveWrapper(
    AnimatedSwitcher(
      duration: Duration(milliseconds: 600),
      child: ListView.separated(
        key: ValueKey(state.tvcoming),
        padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
        controller: state.tvController,
        separatorBuilder: (_, index) => const _SeparatorItem(),
        itemBuilder: adapter.itemBuilder,
        itemCount: adapter.itemCount,
      ),
    ),
  );
}

class _SeparatorItem extends StatelessWidget {
  const _SeparatorItem({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: Adapt.px(190)),
      child: Divider(),
    );
  }
}
