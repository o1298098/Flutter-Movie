import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/style/themestyle.dart';
import 'package:shimmer/shimmer.dart';

import 'state.dart';

Widget buildView(BodyState state, Dispatch dispatch, ViewService viewService) {
  final _adapter = viewService.buildAdapter();

  final width = Adapt.screenW() / 3;
  return state.listItems == null
      ? _ShimmerBody()
      : SliverGrid(
          delegate: SliverChildBuilderDelegate((context, index) {
            return _adapter.itemBuilder(context, index);
          }, childCount: _adapter.itemCount),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: width,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: Adapt.px(10),
            mainAxisSpacing: Adapt.px(10),
          ),
        );
}

class _ShimmerCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: (Adapt.screenW() - Adapt.px(20)) / 3,
      height: Adapt.screenW() / 2,
      color: Colors.grey,
    );
  }
}

class _ShimmerBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return SliverToBoxAdapter(
        child: Shimmer.fromColors(
      baseColor: _theme.primaryColorDark,
      highlightColor: _theme.primaryColorLight,
      child: Wrap(
        spacing: Adapt.px(10),
        runSpacing: Adapt.px(10),
        children: <Widget>[
          _ShimmerCell(),
          _ShimmerCell(),
          _ShimmerCell(),
          _ShimmerCell(),
          _ShimmerCell(),
          _ShimmerCell(),
          _ShimmerCell(),
          _ShimmerCell(),
          _ShimmerCell()
        ],
      ),
    ));
  }
}
