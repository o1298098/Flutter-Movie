import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/enums/genres.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/searchresult.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/views/trending_page/action.dart';
import 'package:parallax_image/parallax_image.dart';

import 'state.dart';

Widget buildView(
    TrendingCellState state, Dispatch dispatch, ViewService viewService) {
  final ThemeData _theme = ThemeStyle.getTheme(viewService.context);
  Widget _buildTredingCell() {
    SearchResult d = state.cellData;
    return GestureDetector(
      key: ValueKey('trendingCell${d.id}+${d.name}'),
      onTap: () => dispatch(TrendingPageActionCreator.cellTapped(d)),
      child: Container(
        margin: EdgeInsets.only(
            bottom: Adapt.px(50), left: Adapt.px(30), right: Adapt.px(30)),
        decoration: BoxDecoration(
          color: _theme.cardColor,
          boxShadow: <BoxShadow>[
            BoxShadow(
                blurRadius: Adapt.px(15),
                offset: Offset(Adapt.px(10), Adapt.px(15)),
                color: _theme.primaryColorDark)
          ],
          borderRadius: BorderRadius.circular(Adapt.px(30)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: Adapt.px(280),
              height: Adapt.px(280),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Adapt.px(30)),
                child: Container(
                  color: _theme.primaryColorDark,
                  child: ParallaxImage(
                    //controller: state.controller,
                    extent: Adapt.px(280),
                    image: CachedNetworkImageProvider(ImageUrl.getUrl(
                        d.posterPath ?? d.profilePath, ImageSize.w300)),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: Adapt.px(50),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: Adapt.px(20),
                ),
                Text(
                  '${state.index + 1}',
                  style: TextStyle(
                      //color: Color(0xFF505050),
                      fontSize: Adapt.px(50),
                      fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  width: Adapt.screenW() - Adapt.px(490),
                  child: Text(
                    d.title ?? d.name,
                    style: TextStyle(
                        // color: Colors.black,
                        fontSize: Adapt.px(28),
                        fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(
                  height: Adapt.px(10),
                ),
                SizedBox(
                    width: Adapt.screenW() - Adapt.px(490),
                    child: Text(
                      (d.genreIds ?? [])
                          .take(3)
                          .map((f) {
                            return Genres.genres[f];
                          })
                          .toList()
                          .join(' / '),
                      style: TextStyle(
                          color: Colors.grey[500], fontSize: Adapt.px(22)),
                    ))
              ],
            ),
            Container(
              height: Adapt.px(280),
              child: IconButton(
                padding: EdgeInsets.only(left: Adapt.px(20)),
                iconSize: Adapt.px(40),
                icon: Icon(Icons.favorite_border),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }

  return _buildTredingCell();
}
