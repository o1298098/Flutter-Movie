import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/models/keyword.dart';
import 'package:movie/style/themestyle.dart';
import 'package:shimmer/shimmer.dart';

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

      final _model = state.keyWords;
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
                      fontWeight: FontWeight.bold, fontSize: Adapt.px(28)),
                ),
              ),
              SizedBox(height: Adapt.px(10)),
              Container(
                padding: EdgeInsets.fromLTRB(
                    Adapt.px(40), 0, Adapt.px(40), Adapt.px(30)),
                child: _model.length == 0
                    ? _ShimmerCell()
                    : Wrap(
                        spacing: Adapt.px(15),
                        direction: Axis.horizontal,
                        children:
                            state.keyWords.map(_buildKeyWordCell).toList(),
                      ),
              ),
              SizedBox(height: Adapt.px(30)),
            ],
          ),
        ),
      );
    },
  );
}

class _ShimmerCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Shimmer.fromColors(
        baseColor: _theme.primaryColorDark,
        highlightColor: _theme.primaryColorLight,
        child: Wrap(
          spacing: Adapt.px(15),
          direction: Axis.horizontal,
          children: <Widget>[
            Container(
              width: Adapt.px(120),
              height: Adapt.px(60),
              decoration: BoxDecoration(
                color: const Color(0xFFEEEEEE),
                borderRadius: BorderRadius.circular(Adapt.px(30)),
              ),
            ),
            Container(
              width: Adapt.px(180),
              height: Adapt.px(60),
              decoration: BoxDecoration(
                color: const Color(0xFFEEEEEE),
                borderRadius: BorderRadius.circular(Adapt.px(30)),
              ),
            ),
            Container(
              width: Adapt.px(200),
              height: Adapt.px(60),
              decoration: BoxDecoration(
                color: const Color(0xFFEEEEEE),
                borderRadius: BorderRadius.circular(Adapt.px(30)),
              ),
            ),
          ],
        ));
  }
}
