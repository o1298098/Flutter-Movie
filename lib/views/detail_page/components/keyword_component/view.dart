import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/customwidgets/shimmercell.dart';
import 'package:movie/models/keyword.dart';
import 'package:movie/style/themestyle.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    KeyWordState state, Dispatch dispatch, ViewService viewService) {
  return Builder(
    builder: (context) {
      final ThemeData _theme = ThemeStyle.getTheme(context);
      Widget _buildKeyWordCell(KeyWordData d) {
        return Chip(
          key: ValueKey('keyword${d.id}'),
          elevation: 3.0,
          backgroundColor: _theme.cardColor,
          label: Text(d.name),
        );
      }

      Widget _buildKeyWord() {
        var _model = state.keyWords;
        return SliverToBoxAdapter(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
                  child: Text(
                    'KeyWords',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: Adapt.px(35)),
                  ),
                ),
                SizedBox(
                  height: Adapt.px(10),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(
                      Adapt.px(40), 0, Adapt.px(40), Adapt.px(30)),
                  child: Wrap(
                    spacing: Adapt.px(15),
                    direction: Axis.horizontal,
                    children: _model.length == 0
                        ? <Widget>[
                            ShimmerCell(
                                Adapt.px(120), Adapt.px(60), Adapt.px(30),
                                baseColor: _theme.primaryColorDark,
                                highlightColor: _theme.primaryColorLight,
                                margin: EdgeInsets.only(top: Adapt.px(20))),
                            ShimmerCell(
                                Adapt.px(180), Adapt.px(60), Adapt.px(30),
                                baseColor: _theme.primaryColorDark,
                                highlightColor: _theme.primaryColorLight,
                                margin: EdgeInsets.only(top: Adapt.px(20))),
                            ShimmerCell(
                                Adapt.px(200), Adapt.px(60), Adapt.px(30),
                                baseColor: _theme.primaryColorDark,
                                highlightColor: _theme.primaryColorLight,
                                margin: EdgeInsets.only(top: Adapt.px(20))),
                          ]
                        : state.keyWords.map(_buildKeyWordCell).toList(),
                  ),
                )
              ],
            ),
          ),
        );
      }

      return _buildKeyWord();
    },
  );
}
