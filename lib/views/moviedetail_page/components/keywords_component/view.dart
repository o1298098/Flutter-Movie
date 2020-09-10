import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/keyword.dart';
import 'package:shimmer/shimmer.dart';

import 'state.dart';

Widget buildView(
    KeyWordsState state, Dispatch dispatch, ViewService viewService) {
  Widget _buildKeyWordChip(KeyWordData k) {
    return Chip(
      elevation: 3.0,
      backgroundColor: Colors.white,
      label: Text(k.name),
    );
  }

  Widget _buildKeyWordShimmer(double w) {
    return SizedBox(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[200],
        highlightColor: Colors.grey[100],
        child: Container(
          width: w,
          height: Adapt.px(50),
          margin: EdgeInsets.only(bottom: Adapt.px(20)),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(Adapt.px(25)),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildKeyBody() {
    if (state.keywords.keywords.length > 0)
      return state.keywords.keywords.map(_buildKeyWordChip).toList();
    else
      return <Widget>[
        _buildKeyWordShimmer(Adapt.px(100)),
        _buildKeyWordShimmer(Adapt.px(200)),
        _buildKeyWordShimmer(Adapt.px(150)),
        _buildKeyWordShimmer(Adapt.px(230)),
        _buildKeyWordShimmer(Adapt.px(150)),
        _buildKeyWordShimmer(Adapt.px(120)),
      ];
  }

  Widget _getKeyWordCell() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(Adapt.px(30)),
          child: Text(I18n.of(viewService.context).tags,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: Adapt.px(40),
                  fontWeight: FontWeight.w800)),
        ),
        Container(
          padding:
              EdgeInsets.fromLTRB(Adapt.px(30), 0, Adapt.px(30), Adapt.px(30)),
          child: Wrap(
            spacing: Adapt.px(15),
            direction: Axis.horizontal,
            children: _buildKeyBody(),
          ),
        ),
      ],
    );
  }

  return _getKeyWordCell();
}
