import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/style/themestyle.dart';
import 'package:shimmer/shimmer.dart';

import 'state.dart';

Widget buildView(
    HeaderState state, Dispatch dispatch, ViewService viewService) {
  final MediaQueryData _mediaQuery = MediaQuery.of(viewService.context);
  final ThemeData _theme = _mediaQuery.platformBrightness == Brightness.light
      ? ThemeStyle.lightTheme
      : ThemeStyle.darkTheme;
  Widget _buildAirDateShimmerCell() {
    return Shimmer.fromColors(
      baseColor: _theme.primaryColorDark,
      highlightColor: _theme.primaryColorLight,
      child: Container(
        width: Adapt.px(300),
        height: Adapt.px(28),
        color: Colors.grey[200],
      ),
    );
  }

  Widget _buildOverWatchShimmerCell() {
    return Shimmer.fromColors(
        baseColor: _theme.primaryColorDark,
        highlightColor: _theme.primaryColorLight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                width: Adapt.screenW() - Adapt.px(350),
                height: Adapt.px(26),
                color: Colors.grey[200]),
            SizedBox(
              height: Adapt.px(8),
            ),
            Container(
                width: Adapt.screenW() - Adapt.px(350),
                height: Adapt.px(26),
                color: Colors.grey[200]),
            SizedBox(
              height: Adapt.px(8),
            ),
            Container(
                width: Adapt.screenW() - Adapt.px(500),
                height: Adapt.px(26),
                color: Colors.grey[200]),
          ],
        ));
  }

  Widget _getAirDateCell() {
    if (state.airDate != null)
      return Text('Air Date:${state.airDate}');
    else
      return _buildAirDateShimmerCell();
  }

  Widget _getOverWatchCell() {
    if (state.overwatch != null)
      return Container(
        width: Adapt.screenW() - Adapt.px(310),
        child: Text(state.overwatch?.isEmpty == true || state.overwatch == null
            ? 'No OverWatch have been added.'
            : state.overwatch),
      );
    else
      return _buildOverWatchShimmerCell();
  }

  return Container(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: Adapt.px(30),
        ),
        Hero(
          tag: 'seasonpic${state.seasonNumber}',
          child: CachedNetworkImage(
            width: Adapt.px(250),
            imageUrl: state.posterurl == null
                ? ImageUrl.emptyimage
                : ImageUrl.getUrl(state.posterurl, ImageSize.w300),
          ),
        ),
        SizedBox(
          width: Adapt.px(20),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: 'seasonname${state.seasonNumber}',
              child: Container(
                width: Adapt.screenW() - Adapt.px(310),
                child: Text(
                  state.name ?? '',
                  style: TextStyle(
                      fontSize: Adapt.px(35), fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: Adapt.px(8),
            ),
            _getAirDateCell(),
            SizedBox(
              height: Adapt.px(20),
            ),
            _getOverWatchCell()
          ],
        )
      ],
    ),
  );
}
