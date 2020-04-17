import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/style/themestyle.dart';
import 'package:shimmer/shimmer.dart';
import 'state.dart';

Widget buildView(
    HeaderState state, Dispatch dispatch, ViewService viewService) {
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
              child: Material(
                  color: Colors.transparent,
                  child: Container(
                    width: Adapt.screenW() - Adapt.px(310),
                    child: Text(
                      state.name ?? '',
                      style: TextStyle(
                          fontSize: Adapt.px(35), fontWeight: FontWeight.bold),
                    ),
                  )),
            ),
            SizedBox(height: Adapt.px(8)),
            _AirDateCell(
              airDate: state.airDate,
            ),
            SizedBox(height: Adapt.px(20)),
            _OverWatchCell(
              overwatch: state.overwatch,
            )
          ],
        )
      ],
    ),
  );
}

class _OverWatchShimmerCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
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
}

class _OverWatchCell extends StatelessWidget {
  final String overwatch;
  const _OverWatchCell({this.overwatch});
  @override
  Widget build(BuildContext context) {
    return overwatch != null
        ? Container(
            width: Adapt.screenW() - Adapt.px(310),
            child: Text(overwatch?.isEmpty == true || overwatch == null
                ? 'No OverWatch have been added.'
                : overwatch),
          )
        : _OverWatchShimmerCell();
  }
}

class _AirDateCell extends StatelessWidget {
  final String airDate;
  const _AirDateCell({@required this.airDate});
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return airDate != null
        ? Text('Air Date:$airDate')
        : Shimmer.fromColors(
            baseColor: _theme.primaryColorDark,
            highlightColor: _theme.primaryColorLight,
            child: Container(
              width: Adapt.px(300),
              height: Adapt.px(28),
              color: Colors.grey[200],
            ),
          );
  }
}
