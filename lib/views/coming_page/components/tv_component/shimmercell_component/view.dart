import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/style/themestyle.dart';
import 'package:shimmer/shimmer.dart';

import 'state.dart';

Widget buildView(
    ShimmerCellState state, Dispatch dispatch, ViewService viewService) {
  final ThemeData _theme = ThemeStyle.getTheme(viewService.context);
  return Offstage(
      offstage: state.showShimmer,
      child: Shimmer.fromColors(
        baseColor: _theme.primaryColorDark,
        highlightColor: _theme.primaryColorLight,
        child: Column(
          children: <Widget>[
            const _ShimmerCell(),
            const _ShimmerCell(),
            const _ShimmerCell(),
            const _ShimmerCell(),
          ],
        ),
      ));
}

class _ShimmerCell extends StatelessWidget {
  const _ShimmerCell({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _color = const Color(0xFFFFFFFF);
    return Container(
      padding: EdgeInsets.symmetric(vertical: Adapt.px(25)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: Adapt.px(220),
            width: Adapt.px(160),
            decoration: BoxDecoration(
              color: _color,
              borderRadius: BorderRadius.circular(Adapt.px(25)),
            ),
          ),
          SizedBox(
            width: Adapt.px(20),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: Adapt.px(10)),
              Container(
                width: Adapt.px(350),
                height: Adapt.px(30),
                color: _color,
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: Adapt.px(150),
                height: Adapt.px(24),
                color: _color,
              ),
              SizedBox(
                height: Adapt.px(8),
              ),
              SizedBox(
                height: Adapt.px(8),
              ),
              Container(
                width: Adapt.screenW() - Adapt.px(300),
                height: Adapt.px(24),
                color: _color,
              ),
              SizedBox(
                height: Adapt.px(8),
              ),
              Container(
                width: Adapt.screenW() - Adapt.px(300),
                height: Adapt.px(24),
                color: _color,
              )
            ],
          )
        ],
      ),
    );
  }
}
