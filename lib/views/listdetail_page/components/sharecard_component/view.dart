import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';

import 'state.dart';

Widget buildView(
    ShareCardState state, Dispatch dispatch, ViewService viewService) {
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

  Widget _buildShareCardHeader() {
    var d = state.listDetailModel;
    int _itemCount = d.itemCount;
    double _totalRated = d.totalRated;
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
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  state.user.photoUrl ?? ''))),
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
                      _buildInfoCell(
                        _itemCount?.toString() ?? '0',
                        'ITEMS',
                        labelColor: Colors.white,
                        titleColor: Colors.white,
                      ),
                      SizedBox(
                        width: Adapt.px(20),
                      ),
                      _buildInfoCell(
                        (_totalRated / _itemCount).toStringAsFixed(1) ?? '0.0',
                        'RATING',
                        labelColor: Colors.white,
                        titleColor: Colors.white,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Adapt.px(20),
                  ),
                  Row(
                    children: <Widget>[
                      _buildInfoCell(
                        _covertDuration(d.runTime ?? 0),
                        'RUNTIME',
                        labelColor: Colors.white,
                        titleColor: Colors.white,
                      ),
                      SizedBox(
                        width: Adapt.px(20),
                      ),
                      _buildInfoCell(
                        '\$${((d.revenue ?? 0) / 1000000000).toStringAsFixed(1)} B',
                        'REVENUE',
                        labelColor: Colors.white,
                        titleColor: Colors.white,
                      ),
                    ],
                  )
                ],
              )
            ]),
      ],
    );
  }

  return _buildShareCardHeader();
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
