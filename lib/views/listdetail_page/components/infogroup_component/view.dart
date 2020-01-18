import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/style/themestyle.dart';

import 'state.dart';

Widget buildView(
    InfoGroupState state, Dispatch dispatch, ViewService viewService) {
  final ThemeData _theme = ThemeStyle.getTheme(viewService.context);
  Widget _buildInfoCell(String value, String title,
      {Widget valueChild,
      Color labelColor = Colors.black,
      Color titleColor = Colors.black}) {
    final titleStyle = TextStyle(
        fontSize: Adapt.px(26),
        //color: titleColor,
        fontWeight: FontWeight.bold);
    final valueStyle = TextStyle(
        //color: labelColor,
        fontWeight: FontWeight.bold,
        fontSize: Adapt.px(28));
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

  Widget _buildInfoGroup() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: Adapt.px(20)),
      decoration: BoxDecoration(
        color: _theme.backgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(Adapt.px(40))),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildInfoCell(state.itemCount.toString() ?? '0', 'ITEMS'),
          Container(
            color: Colors.grey[300],
            width: Adapt.px(1),
            height: Adapt.px(60),
          ),
          _buildInfoCell(
            '',
            'RATING',
            valueChild: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  (state.rating / state.itemCount).toStringAsFixed(1) ?? '0.0',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: Adapt.px(28)),
                ),
                Icon(
                  Icons.star,
                  size: Adapt.px(20),
                )
              ],
            ),
          ),
          Container(
            color: Colors.grey[300],
            width: Adapt.px(1),
            height: Adapt.px(60),
          ),
          _buildInfoCell(
            _covertDuration(state.runTime ?? 0),
            'RUNTIME',
          ),
          Container(
            color: Colors.grey[300],
            width: Adapt.px(1),
            height: Adapt.px(60),
          ),
          _buildInfoCell(
            '\$${((state.revenue ?? 0) / 1000000000).toStringAsFixed(1)} B',
            'REVENUE',
          ),
        ],
      ),
    );
  }

  return _buildInfoGroup();
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
