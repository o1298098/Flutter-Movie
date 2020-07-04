import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/seasondetail.dart';
import 'package:movie/style/themestyle.dart';
import 'package:shimmer/shimmer.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    SeasonState state, Dispatch dispatch, ViewService viewService) {
  return AnimatedSwitcher(
    duration: Duration(milliseconds: 300),
    child: state.seasons == null
        ? const _ShimmerList()
        : state.seasons.length > 0
            ? _SeasonPanel(
                seasons: state.seasons,
                onTap: (d) => dispatch(SeasonActionCreator.cellTapped(d)),
              )
            : const SizedBox(),
  );
}

class _SeasonCell extends StatelessWidget {
  final Season data;
  final Function(Season) onTap;
  const _SeasonCell({this.data, this.onTap});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    final _subStyle =
        TextStyle(fontSize: Adapt.px(16), color: const Color(0xFF717171));
    final _width = Adapt.px(130);
    return GestureDetector(
      onTap: () => onTap(data),
      child: SizedBox(
        width: _width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: _width,
              height: Adapt.px(200),
              decoration: BoxDecoration(
                color: _theme.primaryColorDark,
                borderRadius: BorderRadius.circular(Adapt.px(20)),
                image: data.posterPath == null
                    ? null
                    : DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                            ImageUrl.getUrl(data.posterPath, ImageSize.w300)),
                      ),
              ),
            ),
            SizedBox(height: Adapt.px(20)),
            Text(
              data?.name ?? '',
              maxLines: 1,
              style: TextStyle(fontSize: Adapt.px(24)),
            ),
            Text(
              data.airDate == null
                  ? '-'
                  : DateFormat.yMMMd().format(DateTime.parse(data?.airDate)),
              style: _subStyle,
            ),
            Text(
              '${data.episodeCount} Episodes',
              style: _subStyle,
            )
          ],
        ),
      ),
    );
  }
}

class _SeasonPanel extends StatelessWidget {
  final List<Season> seasons;

  final Function(Season) onTap;
  const _SeasonPanel({this.seasons, this.onTap});
  @override
  Widget build(BuildContext context) {
    final _padding = Adapt.px(40);
    final _listViewHeight = Adapt.px(320);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: _padding),
          child: Text(
            'Seasons',
            style: TextStyle(
              fontSize: Adapt.px(28),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: Adapt.px(30)),
        SizedBox(
          height: _listViewHeight,
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: _padding),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (_, __) => SizedBox(width: Adapt.px(40)),
            itemCount: seasons.length,
            itemBuilder: (_, index) => _SeasonCell(
              data: seasons[(seasons.length - 1) - index],
              onTap: onTap,
            ),
          ),
        ),
      ],
    );
  }
}

class _ShimmerCell extends StatelessWidget {
  const _ShimmerCell();
  @override
  Widget build(BuildContext context) {
    final _width = Adapt.px(130);
    final _color = const Color(0xFFFFFFFF);
    return SizedBox(
      width: _width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: _width,
            height: Adapt.px(200),
            decoration: BoxDecoration(
              color: _color,
              borderRadius: BorderRadius.circular(Adapt.px(20)),
            ),
          ),
          SizedBox(height: Adapt.px(20)),
          Container(
            height: Adapt.px(20),
            color: _color,
          ),
          SizedBox(height: Adapt.px(8)),
          Container(
            height: Adapt.px(14),
            width: Adapt.px(80),
            color: _color,
          ),
          SizedBox(height: Adapt.px(8)),
          Container(
            height: Adapt.px(14),
            width: Adapt.px(60),
            color: _color,
          ),
        ],
      ),
    );
  }
}

class _ShimmerList extends StatelessWidget {
  const _ShimmerList();
  @override
  Widget build(BuildContext context) {
    final _padding = Adapt.px(40);
    final _listViewHeight = Adapt.px(320);
    final _theme = ThemeStyle.getTheme(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: _padding),
          child: Text(
            'Seasons',
            style: TextStyle(
              fontSize: Adapt.px(28),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: Adapt.px(30)),
        SizedBox(
          height: _listViewHeight,
          child: Shimmer.fromColors(
            baseColor: _theme.primaryColorDark,
            highlightColor: _theme.primaryColorLight,
            child: ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: _padding),
              scrollDirection: Axis.horizontal,
              separatorBuilder: (_, __) => SizedBox(width: Adapt.px(40)),
              itemCount: 5,
              itemBuilder: (_, index) => const _ShimmerCell(),
            ),
          ),
        ),
      ],
    );
  }
}
