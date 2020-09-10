import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';

import 'state.dart';

Widget buildView(
    ShareCardState state, Dispatch dispatch, ViewService viewService) {
  final d = state.listDetailModel;
  final int _itemCount = d.itemCount;
  final double _totalRated = d.totalRated;
  return Column(
    children: <Widget>[
      SizedBox(
        height: Adapt.px(20),
      ),
      Text(d.listName,
          style: TextStyle(
              color: Colors.white,
              fontSize: Adapt.px(45),
              fontWeight: FontWeight.bold)),
      SizedBox(
        height: Adapt.px(20),
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: Adapt.px(150),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: Adapt.px(80),
                  height: Adapt.px(80),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Adapt.px(40)),
                      image: state.user.photoUrl != null
                          ? DecorationImage(
                              image: CachedNetworkImageProvider(
                                  state.user.photoUrl))
                          : null),
                ),
                SizedBox(
                  height: Adapt.px(10),
                ),
                Text(
                  'A list by',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: Adapt.px(30)),
                ),
                SizedBox(
                  height: Adapt.px(5),
                ),
                SizedBox(
                  width: Adapt.px(130),
                  child: Text(
                    state.user.displayName ?? '',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: Adapt.px(20),
          ),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  _InfoCell(
                    value: _itemCount?.toString() ?? '0',
                    title: 'ITEMS',
                  ),
                  SizedBox(
                    width: Adapt.px(20),
                  ),
                  _InfoCell(
                    value:
                        (_totalRated / _itemCount).toStringAsFixed(1) ?? '0.0',
                    title: 'RATING',
                  ),
                ],
              ),
              SizedBox(height: Adapt.px(20)),
              Row(
                children: <Widget>[
                  _InfoCell(
                    value: _covertDuration(d.runTime ?? 0),
                    title: 'RUNTIME',
                  ),
                  SizedBox(width: Adapt.px(20)),
                  _InfoCell(
                    value:
                        '\$${((d.revenue ?? 0) / 1000000000).toStringAsFixed(1)} B',
                    title: 'REVENUE',
                  ),
                ],
              )
            ],
          )
        ],
      ),
    ],
  );
}

String _covertDuration(int d) {
  String result = '';
  Duration duration = Duration(minutes: d);
  int h = duration.inHours;
  int countedMin = h * 60;
  int m = duration.inMinutes - countedMin;
  result += h > 0 ? '$h H ' : '';
  result += '$m M';
  return result;
}

class _InfoCell extends StatelessWidget {
  final Widget valueChild;
  final String value;
  final String title;
  _InfoCell({
    this.title,
    this.value,
    this.valueChild,
  });
  @override
  Widget build(BuildContext context) {
    final titleStyle = TextStyle(
        fontSize: Adapt.px(26),
        fontWeight: FontWeight.bold,
        color: const Color(0xFFFFFFFF));
    final valueStyle = TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: Adapt.px(28),
        color: const Color(0xFFFFFFFF));
    return SizedBox(
      width: Adapt.px(160),
      child: Column(
        children: <Widget>[
          valueChild == null
              ? Text(
                  value ?? '',
                  style: valueStyle,
                )
              : valueChild,
          SizedBox(
            height: Adapt.px(8),
          ),
          Text(
            title,
            style: titleStyle,
          ),
        ],
      ),
    );
  }
}
