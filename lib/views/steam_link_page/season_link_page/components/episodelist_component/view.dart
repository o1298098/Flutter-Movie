import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/style/themestyle.dart';
import 'package:shimmer/shimmer.dart';

import 'state.dart';

Widget buildView(
    EpisodeListState state, Dispatch dispatch, ViewService viewService) {
  final ThemeData _theme = ThemeStyle.getTheme(viewService.context);
  final _adapter = viewService.buildAdapter();
  Widget _buildShimmerCell() {
    final _color = Colors.grey[300];
    final _rightWdith = Adapt.screenW() - Adapt.px(300);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: Adapt.px(220),
          height: Adapt.px(130),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Adapt.px(10)),
            color: _color,
          ),
        ),
        SizedBox(width: Adapt.px(20)),
        Container(
            width: Adapt.screenW() - Adapt.px(300),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    color: _color, width: Adapt.px(200), height: Adapt.px(30)),
                SizedBox(height: Adapt.px(10)),
                Container(
                    color: _color, width: _rightWdith, height: Adapt.px(20)),
                SizedBox(height: Adapt.px(10)),
                Container(
                    color: _color, width: _rightWdith, height: Adapt.px(20)),
                SizedBox(height: Adapt.px(10)),
                Container(
                    color: _color, width: Adapt.px(400), height: Adapt.px(20)),
              ],
            ))
      ],
    );
  }

  Widget _buildShimmerTabview() {
    return Shimmer.fromColors(
      baseColor: _theme.primaryColorDark,
      highlightColor: _theme.primaryColorLight,
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
          child: Column(
            children: <Widget>[
              _buildShimmerCell(),
              SizedBox(height: Adapt.px(30)),
              _buildShimmerCell(),
              SizedBox(height: Adapt.px(30)),
              _buildShimmerCell(),
              SizedBox(height: Adapt.px(30)),
              _buildShimmerCell()
            ],
          )),
    );
  }

  Widget _buildEpisodeList() {
    return state.episodes != null
        ? MediaQuery.removePadding(
            context: viewService.context,
            removeTop: true,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
              itemCount: _adapter.itemCount,
              separatorBuilder: (_, __) => SizedBox(
                height: Adapt.px(14),
              ),
              itemBuilder: _adapter.itemBuilder,
            ))
        : _buildShimmerTabview();
  }

  return _buildEpisodeList();
}
