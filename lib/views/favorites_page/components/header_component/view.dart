import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/style/themestyle.dart';
import 'package:shimmer/shimmer.dart';

import 'state.dart';

Widget buildView(
    HeaderState state, Dispatch dispatch, ViewService viewService) {
  final d = state.selectedMedia;
  if (d != null) {
    String name = d.name;
    String datetime = d.releaseDate;
    return FadeTransition(
      opacity: Tween(begin: 0.0, end: 1.0).animate(state.animationController),
      child: Container(
        height: Adapt.px(550),
        padding: EdgeInsets.all(Adapt.px(30)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              name ?? '',
              maxLines: 2,
              style: TextStyle(
                  fontSize: Adapt.px(45), fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: Adapt.px(10),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  DateFormat.yMMMd()
                      .format(DateTime.parse(datetime ?? '1990-01-01')),
                  style: TextStyle(fontSize: Adapt.px(26)),
                ),
                SizedBox(
                  width: Adapt.px(20),
                ),
                RatingBarIndicator(
                  itemSize: Adapt.px(30),
                  itemPadding: EdgeInsets.symmetric(horizontal: Adapt.px(4)),
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  unratedColor: Colors.grey,
                  rating: (d.rated ?? 0) / 2,
                ),
                SizedBox(
                  width: Adapt.px(10),
                ),
                Text(d.rated?.toStringAsFixed(1) ?? '0.0',
                    style: TextStyle(fontSize: Adapt.px(26)))
              ],
            ),
            SizedBox(
              height: Adapt.px(10),
            ),
            Text(
              d.overwatch ?? '',
              maxLines: 9,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: Adapt.px(28),
              ),
            ),
          ],
        ),
      ),
    );
  } else
    return _ShimmerHeader();
}

class _ShimmerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    final Color _baseColor = Colors.grey[200];
    return Container(
      height: Adapt.px(550),
      padding: EdgeInsets.all(Adapt.px(30)),
      child: Shimmer.fromColors(
        baseColor: _theme.primaryColorDark,
        highlightColor: _theme.primaryColorLight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: _baseColor,
              height: Adapt.px(40),
              width: Adapt.px(400),
            ),
            SizedBox(
              height: Adapt.px(15),
            ),
            Container(
              color: _baseColor,
              width: Adapt.px(300),
              height: Adapt.px(30),
            ),
            SizedBox(
              height: Adapt.px(15),
            ),
            Container(
              color: _baseColor,
              width: Adapt.screenW(),
              height: Adapt.px(26),
            ),
            SizedBox(
              height: Adapt.px(10),
            ),
            Container(
              color: _baseColor,
              width: Adapt.screenW(),
              height: Adapt.px(26),
            ),
            SizedBox(
              height: Adapt.px(10),
            ),
            Container(
              color: _baseColor,
              width: Adapt.screenW(),
              height: Adapt.px(26),
            ),
            SizedBox(
              height: Adapt.px(10),
            ),
            Container(
              color: _baseColor,
              width: Adapt.screenW(),
              height: Adapt.px(26),
            ),
            SizedBox(
              height: Adapt.px(10),
            ),
            Container(
              color: _baseColor,
              width: Adapt.px(600),
              height: Adapt.px(26),
            ),
          ],
        ),
      ),
    );
  }
}
