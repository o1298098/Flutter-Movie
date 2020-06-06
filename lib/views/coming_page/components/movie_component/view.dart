import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/customwidgets/keepalive_widget.dart';
import 'package:movie/models/enums/genres.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/videolist.dart';
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
        controller: state.movieController,
        cacheExtent: Adapt.px(180),
        separatorBuilder: (_, __) => Divider(),
        itemCount: _count + 1,
        itemBuilder: (_, index) {
          if (index == _count)
            return Offstage(
              offstage:
                  state.moviecoming.page == state.moviecoming.totalPages &&
                      _count > 0,
              child: _ShimmerList(),
            );
          final d = state.moviecoming.results[index];
          return _MovieCell(
            data: d,
            onTap: () => dispatch(MovieListActionCreator.cellTapped(d)),
          );
        },
      )));
}

class _ShimmerCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Adapt.px(20)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              width: Adapt.px(120),
              height: Adapt.px(180),
              color: const Color(0xFFEEEEEE)),
          SizedBox(
            width: Adapt.px(20),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: Adapt.px(350),
                height: Adapt.px(30),
                color: const Color(0xFFEEEEEE),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: Adapt.px(150),
                height: Adapt.px(24),
                color: const Color(0xFFEEEEEE),
              ),
              SizedBox(
                height: Adapt.px(8),
              ),
              SizedBox(
                height: Adapt.px(8),
              ),
              Container(
                width: Adapt.screenW() - Adapt.px(300),
                height: Adapt.px(24),
                color: const Color(0xFFEEEEEE),
              ),
              SizedBox(
                height: Adapt.px(8),
              ),
              Container(
                width: Adapt.screenW() - Adapt.px(300),
                height: Adapt.px(24),
                color: const Color(0xFFEEEEEE),
              )
            ],
          )
        ],
      ),
    );
  }
}

class _ShimmerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Shimmer.fromColors(
      baseColor: _theme.primaryColorDark,
      highlightColor: _theme.primaryColorLight,
      child: Column(children: List(4).map((e) => _ShimmerCell()).toList()),
    );
  }
}

class _MovieCell extends StatelessWidget {
  final VideoListResult data;
  final Function onTap;
  const _MovieCell({@required this.data, this.onTap});

  Widget _buildGenreChip(int id) {
    return Container(
      margin: EdgeInsets.only(right: Adapt.px(10)),
      padding: EdgeInsets.all(Adapt.px(8)),
      child: Text(
        Genres.movieList[id],
        style: TextStyle(fontSize: Adapt.px(24)),
      ),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(Adapt.px(20))),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return InkWell(
      onTap: onTap,
      key: ValueKey<int>(data.id),
      child: Container(
        padding: EdgeInsets.all(Adapt.px(20)),
        child: Row(
          children: <Widget>[
            Container(
              width: Adapt.px(120),
              height: Adapt.px(180),
              decoration: BoxDecoration(
                  color: _theme.primaryColorDark,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                          ImageUrl.getUrl(data.posterPath, ImageSize.w300)))),
            ),
            SizedBox(
              width: Adapt.px(20),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: Adapt.px(500),
                  child: Text(
                    data?.title ?? '',
                    style: TextStyle(
                        fontSize: Adapt.px(30), fontWeight: FontWeight.bold),
                  ),
                ),
                Text("Release on: " + data?.releaseDate ?? '-',
                    style: TextStyle(
                        color: Colors.grey[700], fontSize: Adapt.px(24))),
                SizedBox(
                  height: Adapt.px(8),
                ),
                Row(
                  children: data.genreIds.take(3).map(_buildGenreChip).toList(),
                ),
                SizedBox(
                  height: Adapt.px(8),
                ),
                Container(
                  width: Adapt.screenW() - Adapt.px(200),
                  child: Text(
                    data.overview ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
