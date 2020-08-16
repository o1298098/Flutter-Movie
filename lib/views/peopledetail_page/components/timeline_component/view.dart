import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/models/enums/media_type.dart';
import 'package:movie/models/models.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/views/peopledetail_page/action.dart';
import 'package:shimmer/shimmer.dart';

import 'state.dart';

Widget buildView(
    TimeLineState state, Dispatch dispatch, ViewService viewService) {
  return _ActingBody(
    data: state.showmovie ? state.movies : state.tvshows,
    scrollPhysics: state.scrollPhysics,
    showMovie: state.showmovie,
    onTap: (d) => dispatch(PeopleDetailPageActionCreator.onCellTapped(
        d.id,
        d.backdropPath,
        d.title ?? d.name,
        d.posterPath,
        d.mediaType == 'movie' ? MediaType.movie : MediaType.person)),
  );
}

class _ShimmerCell extends StatelessWidget {
  const _ShimmerCell();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: Adapt.px(24),
              width: Adapt.px(500),
              color: const Color(0xFFEEEEEE),
            ),
            SizedBox(
              height: Adapt.px(8),
            ),
            Container(
              height: Adapt.px(24),
              width: Adapt.px(150),
              color: const Color(0xFFEEEEEE),
            ),
          ],
        ),
      ],
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 10),
              const _ShimmerCell(),
              const SizedBox(height: 20),
              const _ShimmerCell(),
              const SizedBox(height: 20),
              const _ShimmerCell(),
              const SizedBox(height: 20),
              const _ShimmerCell(),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class _Cell extends StatelessWidget {
  final CombinedCastData data;
  final Function onTap;
  const _Cell({Key key, @required this.data, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final double _leftwidth = (Adapt.screenW() - 100);
    String date =
        data.mediaType == 'movie' ? data.releaseDate : data.firstAirDate;
    date = date == null || date?.isEmpty == true
        ? '-'
        : DateTime.parse(date).year.toString();
    return GestureDetector(
      key: ValueKey('timelineCell${data.creditId}'),
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: _leftwidth,
                  child: Text(data.title ?? data.name,
                      style: TextStyle(fontWeight: FontWeight.w600)),
                ),
                SizedBox(
                    width: _leftwidth,
                    child: Text(
                        data?.character?.isEmpty == true ||
                                data.character == null
                            ? '-'
                            : data.character,
                        style: TextStyle(color: Colors.grey[400])))
              ],
            ),
            Text(date)
          ],
        ),
      ),
    );
  }
}

class _ActingBody extends StatelessWidget {
  final bool showMovie;
  final List<CombinedCastData> data;
  final Function(CombinedCastData) onTap;
  final ScrollPhysics scrollPhysics;
  const _ActingBody(
      {this.showMovie, this.data, this.onTap, this.scrollPhysics});
  @override
  Widget build(BuildContext context) {
    return data.length > 0
        ? SliverList(
            delegate: SliverChildBuilderDelegate((_, index) {
            final d = data[index];
            return _Cell(
              key: ValueKey("Cell${d.id}"),
              data: d,
              onTap: () => onTap(d),
            );
          }, childCount: data.length))
        : _ShimmerList();
  }
}
