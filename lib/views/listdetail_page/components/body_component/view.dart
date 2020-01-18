import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/style/themestyle.dart';
import 'package:shimmer/shimmer.dart';

import 'state.dart';

Widget buildView(BodyState state, Dispatch dispatch, ViewService viewService) {
  final ThemeData _theme = ThemeStyle.getTheme(viewService.context);
  final _adapter = viewService.buildAdapter();

  Widget _listShimmerCell() {
    return Container(
      width: (Adapt.screenW() - Adapt.px(20)) / 3,
      height: Adapt.screenW() / 2,
      color: Colors.grey,
    );
  }

  Widget _buildShimmerBody() {
    return SliverToBoxAdapter(
        child: Shimmer.fromColors(
      baseColor: _theme.primaryColorDark,
      highlightColor: _theme.primaryColorLight,
      child: Wrap(
        spacing: Adapt.px(10),
        runSpacing: Adapt.px(10),
        children: <Widget>[
          _listShimmerCell(),
          _listShimmerCell(),
          _listShimmerCell(),
          _listShimmerCell(),
          _listShimmerCell(),
          _listShimmerCell(),
          _listShimmerCell(),
          _listShimmerCell(),
          _listShimmerCell()
        ],
      ),
    ));
  }

  Widget _buildBody() {
    final width = Adapt.screenW() / 3;
    return state.listItems == null
        ? _buildShimmerBody()
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

  return _buildBody();
}
