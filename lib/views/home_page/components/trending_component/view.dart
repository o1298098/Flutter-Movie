import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/enums/media_type.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/views/home_page/action.dart';
import 'package:shimmer/shimmer.dart';

import 'state.dart';

Widget buildView(
    TrendingState state, Dispatch dispatch, ViewService viewService) {
  final MediaQueryData _mediaQuery = MediaQuery.of(viewService.context);
  final ThemeData _theme = ThemeStyle.getTheme(viewService.context);
  Widget _buildFrontTitel(String title, Widget action,
      {EdgeInsetsGeometry padding =
          const EdgeInsets.symmetric(horizontal: 20)}) {
    return Padding(
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style:
                TextStyle(fontSize: Adapt.px(35), fontWeight: FontWeight.bold),
          ),
          action
        ],
      ),
    );
  }

  Widget _buildTrending() {
    final double _size = (Adapt.screenW() - Adapt.px(70)) / 2;
    Widget _child = state.trending.results.length > 0
        ? StaggeredGridView.countBuilder(
            key: ValueKey('Trending'),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 4,
            staggeredTileBuilder: (int index) =>
                new StaggeredTile.count(2, index == 0 ? 2 : 1),
            mainAxisSpacing: Adapt.px(5),
            crossAxisSpacing: Adapt.px(5),
            itemCount: 3,
            itemBuilder: (BuildContext contxt, int index) {
              var d = state.trending.results[index];
              return GestureDetector(
                onTap: () => dispatch(HomePageActionCreator.onCellTapped(
                    d.id,
                    d.backdropPath,
                    d.title ?? d.name,
                    d.posterPath,
                    d.title != null ? MediaType.movie : MediaType.tv)),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: Adapt.px(10)),
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                    color: _theme.primaryColorDark,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                        ImageUrl.getUrl(d.backdropPath, ImageSize.w400),
                      ),
                    ),
                  ),
                  child: Text(
                    d.title ?? d.name,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Adapt.px(30) / _mediaQuery.textScaleFactor,
                        fontWeight: FontWeight.bold,
                        shadows: <Shadow>[Shadow(offset: Offset(1, 1))]),
                  ),
                ),
              );
            },
          )
        : Shimmer.fromColors(
            baseColor: _theme.primaryColorDark,
            highlightColor: _theme.primaryColorLight,
            child: Row(
              children: <Widget>[
                Container(
                  width: _size,
                  height: _size,
                  color: Colors.grey[200],
                ),
                SizedBox(
                  width: Adapt.px(10),
                ),
                Column(
                  children: <Widget>[
                    Container(
                      width: _size,
                      height: (_size - Adapt.px(10)) / 2,
                      color: Colors.grey[200],
                    ),
                    SizedBox(
                      height: Adapt.px(10),
                    ),
                    Container(
                      width: _size,
                      height: (_size - Adapt.px(10)) / 2,
                      color: Colors.grey[200],
                    )
                  ],
                )
              ],
            ),
          );
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 600),
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          child: _child,
        ));
  }

  return Column(
    children: <Widget>[
      _buildFrontTitel(
        'Trending',
        GestureDetector(
          onTap: () => dispatch(HomePageActionCreator.onTrendingMore()),
          child: Text(
            I18n.of(viewService.context).more,
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: Adapt.px(30),
        ),
      ),
      SizedBox(height: Adapt.px(30)),
      _buildTrending(),
      SizedBox(height: Adapt.px(50)),
    ],
  );
}
