import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/episode_model.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/views/seasondetail_page/action.dart';
import 'package:movie/widgets/expandable_text.dart';
import 'package:movie/widgets/linear_progress_Indicator.dart';
import 'package:shimmer/shimmer.dart';

import 'state.dart';

Widget buildView(
    EpisodesState state, Dispatch dispatch, ViewService viewService) {
  return state.episodes.length > 0
      ? SliverList(
          delegate: SliverChildBuilderDelegate((_, index) {
          return _EpisodeCell(
            data: state.episodes[index],
            onTap: (d) =>
                dispatch(SeasonDetailPageActionCreator.episodeCellTapped(d)),
          );
        }, childCount: state.episodes.length))
      : const _ShimmerList();
}

class _ShimmerCell extends StatelessWidget {
  const _ShimmerCell();
  @override
  Widget build(BuildContext context) {
    final _color = const Color(0xFFFFFFFF);
    return Container(
      //height: Adapt.px(400),
      margin: EdgeInsets.only(
        top: Adapt.px(50),
      ),
      padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: Adapt.px(220),
                width: Adapt.px(380),
                transform:
                    Matrix4.translationValues(-Adapt.px(40), -Adapt.px(40), 0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(Adapt.px(20)),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: Adapt.px(20),
                    width: Adapt.px(200),
                    color: _color,
                  ),
                  SizedBox(height: Adapt.px(5)),
                  Container(
                    height: Adapt.px(20),
                    width: Adapt.px(100),
                    color: _color,
                  ),
                  SizedBox(height: Adapt.px(10)),
                ],
              )
            ],
          ),
          Container(
            height: Adapt.px(20),
            width: Adapt.px(120),
            color: _color,
          ),
          SizedBox(height: Adapt.px(10)),
          Container(
            height: Adapt.px(18),
            color: _color,
          ),
          SizedBox(height: Adapt.px(8)),
          Container(
            height: Adapt.px(18),
            color: _color,
          ),
          SizedBox(height: Adapt.px(8)),
          Container(
            height: Adapt.px(18),
            width: Adapt.px(320),
            color: _color,
          ),
          SizedBox(height: Adapt.px(10)),
        ],
      ),
    );
  }
}

class _ShimmerList extends StatelessWidget {
  const _ShimmerList();
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return SliverToBoxAdapter(
      child: Shimmer.fromColors(
        baseColor: _theme.primaryColorDark,
        highlightColor: _theme.primaryColorLight,
        child: SizedBox(
          child: ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
                horizontal: Adapt.px(40), vertical: Adapt.px(30)),
            separatorBuilder: (_, __) => SizedBox(height: Adapt.px(60)),
            itemCount: 3,
            itemBuilder: (_, __) => const _ShimmerCell(),
          ),
        ),
      ),
    );
  }
}

class _EpisodeCell extends StatelessWidget {
  final Episode data;
  final Function(Episode) onTap;
  const _EpisodeCell({this.data, this.onTap});
  @override
  Widget build(BuildContext context) {
    final _imageHeight = Adapt.px(220);
    final _theme = ThemeStyle.getTheme(context);
    final _shadowColor = _theme.brightness == Brightness.light
        ? const Color(0xFFE0E0E0)
        : const Color(0x00000000);
    final DateTime _airDate = DateTime.parse(data.airDate ?? '1990-01-01');
    final bool _canPlay = DateTime.now().isAfter(_airDate);
    return Container(
      margin: EdgeInsets.only(
        left: Adapt.px(40),
        right: Adapt.px(40),
        top: Adapt.px(50),
        bottom: Adapt.px(30),
      ),
      padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
      decoration: BoxDecoration(
          color: _theme.cardColor,
          borderRadius: BorderRadius.circular(Adapt.px(20)),
          boxShadow: [
            BoxShadow(
              color: _shadowColor,
              offset: Offset(Adapt.px(10), Adapt.px(20)),
              blurRadius: Adapt.px(30),
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (_canPlay) onTap(data);
                },
                child: Container(
                  height: _imageHeight,
                  width: Adapt.px(380),
                  transform: Matrix4.translationValues(
                      -Adapt.px(40), -Adapt.px(40), 0),
                  decoration: BoxDecoration(
                    color: _theme.primaryColorDark,
                    borderRadius: BorderRadius.circular(Adapt.px(20)),
                    boxShadow: [
                      BoxShadow(
                          color: _shadowColor,
                          offset: Offset(Adapt.px(10), Adapt.px(20)),
                          blurRadius: Adapt.px(20),
                          spreadRadius: -Adapt.px(10))
                    ],
                    image: data.stillPath == null
                        ? null
                        : DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                              ImageUrl.getUrl(data.stillPath, ImageSize.w300),
                            ),
                          ),
                  ),
                  child: Stack(children: [
                    _canPlay
                        ? _PlayArrow(height: _imageHeight)
                        : const SizedBox(),
                    data.playState ? const _WatchedCell() : const SizedBox(),
                  ]),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'EP ${data.episodeNumber}',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: Adapt.px(30),
                    ),
                  ),
                  SizedBox(height: Adapt.px(5)),
                  Text(
                    data.airDate == null
                        ? '-'
                        : DateFormat.yMMMd()
                            .format(DateTime.parse(data.airDate)),
                    style: TextStyle(
                      fontSize: Adapt.px(20),
                      color: const Color(0xFF717171),
                    ),
                  ),
                  SizedBox(height: Adapt.px(10)),
                  Row(children: [
                    LinearGradientProgressIndicator(
                      value: data.voteAverage / 10,
                      width: Adapt.px(120),
                    ),
                    SizedBox(width: Adapt.px(10)),
                    Text(
                      data.voteAverage.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: Adapt.px(18),
                        color: const Color(0xFF717171),
                      ),
                    )
                  ])
                ],
              )
            ],
          ),
          Text(
            data.name,
            style:
                TextStyle(fontSize: Adapt.px(26), fontWeight: FontWeight.w600),
          ),
          SizedBox(height: Adapt.px(10)),
          ExpandableText(
            data.overview,
            maxLines: 3,
            style: TextStyle(
              color: const Color(0xFF717171),
            ),
          ),
          SizedBox(height: Adapt.px(40)),
        ],
      ),
    );
  }
}

class _PlayArrow extends StatelessWidget {
  final double height;
  const _PlayArrow({this.height});
  @override
  Widget build(BuildContext context) {
    final _brightness = MediaQuery.of(context).platformBrightness;
    return Container(
      height: height,
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Adapt.px(50)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            color: _brightness == Brightness.light
                ? const Color(0x40FFFFFF)
                : const Color(0x40000000),
            width: Adapt.px(100),
            height: Adapt.px(100),
            child: Icon(
              Icons.play_arrow,
              size: 25,
              color: const Color(0xFFFFFFFF),
            ),
          ),
        ),
      ),
    );
  }
}

class _WatchedCell extends StatelessWidget {
  const _WatchedCell();
  @override
  Widget build(BuildContext context) {
    final _brightness = MediaQuery.of(context).platformBrightness;
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
            color: _brightness == Brightness.light
                ? const Color(0xAAF0F0F0)
                : const Color(0xAA202020),
            borderRadius: BorderRadius.circular(5)),
        child: Text(
          'Watched',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
