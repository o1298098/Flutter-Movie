import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/style/themestyle.dart';

import 'state.dart';

Widget buildView(
    InfoGroupState state, Dispatch dispatch, ViewService viewService) {
  final ThemeData _theme = ThemeStyle.getTheme(viewService.context);

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
        _InfoCell(value: state.itemCount.toString() ?? '0', title: 'ITEMS'),
        Container(
          color: Colors.grey[300],
          width: Adapt.px(1),
          height: Adapt.px(60),
        ),
        _InfoCell(
          value: '',
          title: 'RATING',
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
        _InfoCell(
          value: _covertDuration(state.runTime ?? 0),
          title: 'RUNTIME',
        ),
        Container(
          color: Colors.grey[300],
          width: Adapt.px(1),
          height: Adapt.px(60),
        ),
        _InfoCell(
          value:
              '\$${((state.revenue ?? 0) / 1000000000).toStringAsFixed(1)} B',
          title: 'REVENUE',
        ),
      ],
    ),
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
    final titleStyle =
        TextStyle(fontSize: Adapt.px(26), fontWeight: FontWeight.bold);
    final valueStyle =
        TextStyle(fontWeight: FontWeight.bold, fontSize: Adapt.px(28));
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
