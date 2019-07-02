import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:shimmer/shimmer.dart';

import 'state.dart';

Widget buildView(ShimmerCellState state, Dispatch dispatch, ViewService viewService) {
  Widget _buildShimmerCell() {
    return SizedBox(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[200],
        highlightColor: Colors.grey[100],
        child: Container(
          padding: EdgeInsets.all(Adapt.px(20)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  width: Adapt.px(120),
                  height: Adapt.px(180),
                  color: Colors.grey[200]),
              SizedBox(
                width: Adapt.px(20),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: Adapt.px(350),
                    height: Adapt.px(30),
                    color: Colors.grey[200],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: Adapt.px(150),
                    height: Adapt.px(24),
                    color: Colors.grey[200],
                  ),
                  SizedBox(
                    height: Adapt.px(8),
                  ),
                  SizedBox(
                    height: Adapt.px(8),
                  ),
                  Container(
                    width: Adapt.screenW()-Adapt.px(300),
                    height: Adapt.px(24),
                    color: Colors.grey[200],
                  ),
                  SizedBox(height: Adapt.px(8),),
                  Container( 
                    width: Adapt.screenW()-Adapt.px(300),
                    height: Adapt.px(24),
                    color: Colors.grey[200],)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  return Offstage(
    offstage: state.showShimmer,
    child: Column(
      children: <Widget>[
        _buildShimmerCell(),
        _buildShimmerCell(),
        _buildShimmerCell(),
        _buildShimmerCell(),
      ],
    ),
  );
}
