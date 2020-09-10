import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/keyword.dart';
import 'package:movie/style/themestyle.dart';
import 'package:shimmer/shimmer.dart';

import 'state.dart';

Widget buildView(
    KeyWordsState state, Dispatch dispatch, ViewService viewService) {
  return SliverToBoxAdapter(
      child: _KeyBody(results: state.keywords?.results ?? []));
}

class _KeyWordChip extends StatelessWidget {
  final KeyWordData keyWordData;
  const _KeyWordChip({this.keyWordData});
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Chip(
      elevation: 3.0,
      backgroundColor: _theme.cardColor,
      label: Text(keyWordData.name),
    );
  }
}

class _KeyWordShimmer extends StatelessWidget {
  final double width;
  const _KeyWordShimmer({this.width});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: Adapt.px(50),
      margin: EdgeInsets.only(bottom: Adapt.px(20)),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(Adapt.px(25)),
      ),
    );
  }
}

class _KeyWordShimmerList extends StatelessWidget {
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
            _KeyWordShimmer(width: Adapt.px(100)),
            _KeyWordShimmer(width: Adapt.px(200)),
            _KeyWordShimmer(width: Adapt.px(150)),
            _KeyWordShimmer(width: Adapt.px(230)),
            _KeyWordShimmer(width: Adapt.px(150)),
            _KeyWordShimmer(width: Adapt.px(120)),
          ],
        ));
  }
}

class _KeyBody extends StatelessWidget {
  final List<KeyWordData> results;
  const _KeyBody({this.results});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(Adapt.px(30)),
          child: Text(I18n.of(context).tags,
              style: TextStyle(
                  fontSize: Adapt.px(40), fontWeight: FontWeight.w800)),
        ),
        Container(
          padding:
              EdgeInsets.fromLTRB(Adapt.px(30), 0, Adapt.px(30), Adapt.px(30)),
          child: results.length > 0
              ? Wrap(
                  spacing: Adapt.px(15),
                  direction: Axis.horizontal,
                  children:
                      results.map((d) => _KeyWordChip(keyWordData: d)).toList(),
                )
              : _KeyWordShimmerList(),
        ),
      ],
    );
  }
}
