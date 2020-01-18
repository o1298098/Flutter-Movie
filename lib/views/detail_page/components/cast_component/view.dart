import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/creditsmodel.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/views/detail_page/action.dart';
import 'package:shimmer/shimmer.dart';

import 'state.dart';

Widget buildView(CastState state, Dispatch dispatch, ViewService viewService) {
  final ThemeData _theme = ThemeStyle.getTheme(viewService.context);
  Widget _buildCastCell(CastData d) {
    final double width = Adapt.px(150);
    return GestureDetector(
      onTap: () => dispatch(MovieDetailPageActionCreator.castCellTapped(
          d.id, d.profilePath, d.name, d.character)),
      child: Column(
        key: ValueKey('Cast${d.id}'),
        children: <Widget>[
          Hero(
              tag: 'people${d.id}',
              child: Material(
                color: Colors.transparent,
                child: Container(
                  margin: EdgeInsets.only(right: Adapt.px(30)),
                  width: width,
                  height: width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Adapt.px(15)),
                      color: _theme.primaryColorDark,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                              ImageUrl.getUrl(d.profilePath, ImageSize.w300)))),
                ),
              )),
          SizedBox(
            height: Adapt.px(10),
          ),
          Container(
              width: width,
              child: Text(
                d.name ?? '',
                maxLines: 2,
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
          Container(
              width: width,
              child: Text(
                d.character ?? '',
                maxLines: 2,
                style: TextStyle(color: Colors.grey, fontSize: Adapt.px(24)),
              ))
        ],
      ),
    );
  }

  Widget _buildCastShimmerCell() {
    double width = Adapt.px(150);
    return Shimmer.fromColors(
      baseColor: _theme.primaryColorDark,
      highlightColor: _theme.primaryColorLight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: Adapt.px(30)),
            width: width,
            height: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Adapt.px(15)),
              color: Colors.grey[200],
            ),
          ),
          SizedBox(
            height: Adapt.px(10),
          ),
          Container(
            width: width,
            height: Adapt.px(24),
            color: Colors.grey[200],
          ),
          SizedBox(
            height: Adapt.px(10),
          ),
          Container(
            width: Adapt.px(100),
            height: Adapt.px(24),
            color: Colors.grey[200],
          )
        ],
      ),
    );
  }

  Widget _buildCast() {
    var _model = state.cast;
    return SliverToBoxAdapter(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: Adapt.px(50),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
              child: Text(
                I18n.of(viewService.context).topBilledCast,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: Adapt.px(35)),
              ),
            ),
            SizedBox(
              height: Adapt.px(30),
            ),
            Container(
              height: Adapt.px(300),
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: _model.length == 0
                      ? <Widget>[
                          SizedBox(
                            width: Adapt.px(40),
                          ),
                          _buildCastShimmerCell(),
                          SizedBox(
                            width: Adapt.px(30),
                          ),
                          _buildCastShimmerCell(),
                          SizedBox(
                            width: Adapt.px(30),
                          ),
                          _buildCastShimmerCell(),
                          SizedBox(
                            width: Adapt.px(30),
                          ),
                          _buildCastShimmerCell()
                        ]
                      : (state.cast.map(_buildCastCell).toList()
                        ..insert(
                            0,
                            SizedBox(
                              width: Adapt.px(40),
                            )))),
            )
          ],
        ),
      ),
    );
  }

  return _buildCast();
}
