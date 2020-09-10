import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/keyword.dart';
import 'package:movie/style/themestyle.dart';
import 'package:shimmer/shimmer.dart';

import 'state.dart';

Widget buildView(
    KeyWordState state, Dispatch dispatch, ViewService viewService) {
  return Builder(
    builder: (context) {
      return SliverToBoxAdapter(
        child: state.keyWords.length == 0
            ? const _ShimmerList()
            : _KeyWordPanel(keywords: state.keyWords),
      );
    },
  );
}

class _KeyWordCell extends StatelessWidget {
  final KeyWordData data;
  const _KeyWordCell({this.data});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Adapt.px(25), vertical: Adapt.px(13)),
      height: Adapt.px(60),
      decoration: BoxDecoration(
          border: Border.all(color: _theme.primaryColorDark),
          borderRadius: BorderRadius.circular(Adapt.px(30))),
      child: Text(
        data.name,
        style:
            TextStyle(fontSize: Adapt.px(24), color: const Color(0xFF717171)),
      ),
    );
  }
}

class _KeyWordPanel extends StatelessWidget {
  final List<KeyWordData> keywords;
  const _KeyWordPanel({this.keywords});
  @override
  Widget build(BuildContext context) {
    final _padding = Adapt.px(40);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            I18n.of(context).keyWords,
            style: TextStyle(
              fontSize: Adapt.px(28),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: Adapt.px(30)),
          SizedBox(
            width: Adapt.screenW(),
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children:
                  keywords.take(15).map((e) => _KeyWordCell(data: e)).toList(),
            ),
          ),
          SizedBox(height: Adapt.px(30)),
        ],
      ),
    );
  }
}

class _ShimmerCell extends StatelessWidget {
  final double width;
  const _ShimmerCell(this.width);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Adapt.px(25), vertical: Adapt.px(13)),
      width: width,
      height: Adapt.px(60),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(
          Adapt.px(30),
        ),
      ),
    );
  }
}

class _ShimmerList extends StatelessWidget {
  const _ShimmerList();
  @override
  Widget build(BuildContext context) {
    final _padding = Adapt.px(40);
    final _theme = ThemeStyle.getTheme(context);
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: _padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Keywords',
              style: TextStyle(
                fontSize: Adapt.px(28),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: Adapt.px(30)),
            Shimmer.fromColors(
              baseColor: _theme.primaryColorDark,
              highlightColor: _theme.primaryColorLight,
              child: SizedBox(
                width: Adapt.screenW(),
                child: Wrap(
                  runAlignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    const _ShimmerCell(80),
                    const _ShimmerCell(100),
                    const _ShimmerCell(90),
                    const _ShimmerCell(120),
                    const _ShimmerCell(80),
                  ],
                ),
              ),
            ),
            SizedBox(height: Adapt.px(30)),
          ],
        ));
  }
}
