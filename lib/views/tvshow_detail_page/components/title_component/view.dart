import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/votecolorhelper.dart';
import 'package:movie/widgets/expandable_text.dart';
import 'package:movie/models/tvshow_detail.dart';
import 'package:movie/style/themestyle.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:ui';

import 'state.dart';

Widget buildView(TitleState state, Dispatch dispatch, ViewService viewService) {
  return AnimatedSwitcher(
    duration: Duration(milliseconds: 300),
    child: state.name == null
        ? const _ShimmerCell()
        : _Title(
            name: state.name,
            genres: state.genres,
            contentRatings: state.contentRatings,
            overview: state.overview,
            vote: state.vote,
          ),
  );
}

class _ShimmerCell extends StatelessWidget {
  const _ShimmerCell();
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    return Shimmer.fromColors(
      baseColor: _theme.primaryColorDark,
      highlightColor: _theme.primaryColorLight,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: Adapt.px(30), horizontal: Adapt.px(40)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Adapt.px(8)),
            Container(
              width: Adapt.px(350),
              height: Adapt.px(25),
              color: _theme.primaryColorDark,
            ),
            SizedBox(height: Adapt.px(20)),
            Container(
              width: Adapt.px(150),
              height: Adapt.px(20),
              color: _theme.primaryColorDark,
            ),
            SizedBox(height: Adapt.px(10)),
            Container(
              width: Adapt.px(100),
              height: Adapt.px(20),
              color: _theme.primaryColorDark,
            ),
            SizedBox(height: Adapt.px(20)),
            Container(
              height: Adapt.px(45),
              width: Adapt.px(80),
              padding: EdgeInsets.symmetric(
                  horizontal: Adapt.px(20), vertical: Adapt.px(8)),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Adapt.px(22.5)),
                  color: _theme.primaryColorDark),
            ),
            SizedBox(height: Adapt.px(40)),
            Container(
              height: Adapt.px(20),
              color: _theme.primaryColorDark,
            ),
            SizedBox(height: Adapt.px(12)),
            Container(
              height: Adapt.px(20),
              color: _theme.primaryColorDark,
            ),
            SizedBox(height: Adapt.px(12)),
            Container(
              width: Adapt.px(350),
              height: Adapt.px(20),
              color: _theme.primaryColorDark,
            ),
          ],
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String name;
  final List<Genre> genres;
  final double vote;
  final ContentRatingModel contentRatings;
  final String overview;
  final ViewService viewService;
  const _Title(
      {this.name,
      this.contentRatings,
      this.genres,
      this.overview,
      this.vote,
      this.viewService});
  @override
  Widget build(BuildContext context) {
    final _rate = contentRatings?.results?.firstWhere(
        (e) => e?.iso31661 == window.locale.countryCode,
        orElse: () => null);
    return Container(
      width: Adapt.screenW(),
      padding: EdgeInsets.symmetric(
          vertical: Adapt.px(30), horizontal: Adapt.px(40)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name ?? '',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Adapt.px(30),
            ),
          ),
          SizedBox(height: Adapt.px(15)),
          Text(
            genres?.take(3)?.map((e) => e.name)?.join(', ') ?? '',
            style: TextStyle(
              color: const Color(0xFF717171),
              fontSize: Adapt.px(22),
            ),
          ),
          SizedBox(height: Adapt.px(8)),
          Text(
            'Certification ${_rate?.rating ?? '-'}',
            style: TextStyle(
              color: const Color(0xFF717171),
              fontSize: Adapt.px(22),
            ),
          ),
          SizedBox(height: Adapt.px(20)),
          Container(
            height: Adapt.px(45),
            padding: EdgeInsets.symmetric(
                horizontal: Adapt.px(20), vertical: Adapt.px(8)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Adapt.px(22.5)),
                color: VoteColorHelper.getColor(vote ?? 0)),
            child: Text(
              vote?.toStringAsFixed(1) ?? '0.0',
              style: TextStyle(
                  color: const Color(0xFFFFFFFF),
                  fontSize: Adapt.px(24),
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(height: Adapt.px(25)),
          ExpandableText(
            overview ?? '',
            maxLines: 3,
            style: TextStyle(
              fontSize: Adapt.px(26),
              color: const Color(0xFF717171),
            ),
          )
        ],
      ),
    );
  }
}
