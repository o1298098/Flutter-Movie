import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/widgets/keepalive_widget.dart';
import 'package:movie/models/enums/genres.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/video_list.dart';
import 'package:movie/style/themestyle.dart';
import 'package:shimmer/shimmer.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    MovieListState state, Dispatch dispatch, ViewService viewService) {
  int _count = state.moviecoming?.results?.length ?? 0;
  return keepAliveWrapper(AnimatedSwitcher(
      duration: Duration(milliseconds: 600),
      child: ListView.separated(
        key: ValueKey(state.moviecoming),
        padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
        controller: state.movieController,
        cacheExtent: Adapt.px(180),
        separatorBuilder: (_, __) => const _SeparatorItem(),
        itemCount: _count + 1,
        itemBuilder: (_, index) {
          if (index == _count)
            return Offstage(
              offstage:
                  state.moviecoming.page == state.moviecoming.totalPages &&
                      _count > 0,
              child: const _ShimmerList(),
            );
          final d = state.moviecoming.results[index];
          return _ItemCell(
            data: d,
            onTap: () => dispatch(MovieListActionCreator.cellTapped(d)),
          );
        },
      )));
}

class _SeparatorItem extends StatelessWidget {
  const _SeparatorItem({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: Adapt.px(190)), child: Divider());
  }
}

class _ShimmerCell extends StatelessWidget {
  const _ShimmerCell({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _rightPanelWidth = Adapt.screenW() - Adapt.px(250);
    final _color = const Color(0xFFFFFFFF);
    return Container(
      padding: EdgeInsets.symmetric(vertical: Adapt.px(25)),
      height: Adapt.px(280),
      child: Row(
        children: [
          Container(
            height: Adapt.px(200),
            width: Adapt.px(160),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Adapt.px(25)),
                color: _color),
          ),
          SizedBox(width: Adapt.px(30)),
          SizedBox(
            width: _rightPanelWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Adapt.px(20)),
                Container(
                    height: Adapt.px(30), width: Adapt.px(300), color: _color),
                SizedBox(height: Adapt.px(5)),
                Container(
                    height: Adapt.px(15), width: Adapt.px(150), color: _color),
                SizedBox(height: Adapt.px(5)),
                Container(
                    height: Adapt.px(15), width: Adapt.px(150), color: _color),
                SizedBox(height: Adapt.px(15)),
                Container(height: Adapt.px(18), color: _color),
                SizedBox(height: Adapt.px(5)),
                Container(
                    height: Adapt.px(18), width: Adapt.px(350), color: _color),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ShimmerList extends StatelessWidget {
  const _ShimmerList({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Shimmer.fromColors(
      baseColor: _theme.primaryColorDark,
      highlightColor: _theme.primaryColorLight,
      child: Column(
        children: List.filled(4, 0).map((e) => const _ShimmerCell()).toList(),
      ),
    );
  }
}

class _ItemCell extends StatelessWidget {
  final VideoListResult data;
  final Function onTap;
  const _ItemCell({@required this.data, this.onTap});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    final _rightPanelWidth = Adapt.screenW() - Adapt.px(250);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: Adapt.px(25)),
        constraints: BoxConstraints(minHeight: Adapt.px(280)),
        child: Row(
          children: [
            Container(
              height: Adapt.px(200),
              width: Adapt.px(160),
              decoration: BoxDecoration(
                color: _theme.primaryColorDark,
                borderRadius: BorderRadius.circular(Adapt.px(25)),
                boxShadow: [
                  BoxShadow(
                      color: _theme.brightness == Brightness.light
                          ? const Color(0xFF8E8E8E)
                          : const Color(0x00000000),
                      offset: Offset(0, Adapt.px(25)),
                      blurRadius: Adapt.px(20),
                      spreadRadius: -Adapt.px(10))
                ],
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                    ImageUrl.getUrl(data.posterPath, ImageSize.w300),
                  ),
                ),
              ),
            ),
            SizedBox(width: Adapt.px(30)),
            SizedBox(
              width: _rightPanelWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title,
                    maxLines: 2,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: Adapt.px(30)),
                  ),
                  SizedBox(height: Adapt.px(5)),
                  data.genreIds.length > 0
                      ? Text(
                          data.genreIds
                              .take(3)
                              .map((e) => Genres.instance.movieList[e])
                              .join(', '),
                          style: TextStyle(
                            color: const Color(0xFF9E9E9E),
                            fontSize: Adapt.px(20),
                          ),
                        )
                      : SizedBox(),
                  SizedBox(height: Adapt.px(5)),
                  Text.rich(
                    TextSpan(children: [
                      TextSpan(
                          text: 'Release on ',
                          style: TextStyle(color: const Color(0xFF9E9E9E))),
                      TextSpan(
                          text: DateFormat.yMMMd()
                              .format(DateTime.parse(data.releaseDate)))
                    ]),
                    style: TextStyle(fontSize: Adapt.px(20)),
                  ),
                  SizedBox(height: Adapt.px(15)),
                  //Text(data.voteAverage.toString()),
                  Text(
                    data.overview,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
