import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/season_detail.dart';
import 'package:movie/style/themestyle.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  final bool watched;
  final Function(Season) onTap;
  const _SeasonCell({this.data, this.onTap, this.watched = false});
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
              child: watched ? const _WatchedCell() : const SizedBox(),
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

class _SeasonPanel extends StatefulWidget {
  final List<Season> seasons;

  final Function(Season) onTap;
  const _SeasonPanel({this.seasons, this.onTap});
  @override
  _SeasonPanelState createState() => _SeasonPanelState();
}

class _SeasonPanelState extends State<_SeasonPanel> {
  final _padding = Adapt.px(40);
  final _listViewHeight = Adapt.px(320);
  List<bool> _watchedMarks;
  @override
  void initState() {
    _watchedMarks = List<bool>.filled(widget.seasons?.length ?? 0, false);
    _markSeason();
    super.initState();
  }

  void _markSeason() async {
    final _marks = List<bool>.filled(widget.seasons?.length ?? 0, false);
    SharedPreferences _pre = await SharedPreferences.getInstance();

    for (var q in widget.seasons) {
      int _index = widget.seasons.indexOf(q);
      List<String> _playStates = _pre.getStringList('TvSeason${q.id}');
      if (_playStates == null)
        _marks[_index] = false;
      else {
        bool _watched = true;
        for (var e in _playStates) {
          if (e == '0') {
            _watched = false;
            break;
          }
        }
        _marks[_index] = _watched;
      }
    }

    setState(() {
      _watchedMarks = _marks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: _padding),
          child: Text(
            I18n.of(context).seasons,
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
            itemCount: widget.seasons.length,
            itemBuilder: (_, index) => _SeasonCell(
              data: widget.seasons[(widget.seasons.length - 1) - index],
              watched: _watchedMarks[(widget.seasons.length - 1) - index],
              onTap: widget.onTap,
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
            I18n.of(context).seasons,
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

class _WatchedCell extends StatelessWidget {
  const _WatchedCell();
  @override
  Widget build(BuildContext context) {
    final _brightness = MediaQuery.of(context).platformBrightness;
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
            color: _brightness == Brightness.light
                ? const Color(0xAAF0F0F0)
                : const Color(0xAA202020),
            borderRadius: BorderRadius.circular(3)),
        child: Text(
          'Watched',
          style: TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
