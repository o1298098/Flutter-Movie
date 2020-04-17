import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/style/themestyle.dart';
import 'package:shimmer/shimmer.dart';

import 'state.dart';

Widget buildView(InfoState state, Dispatch dispatch, ViewService viewService) {
  final ThemeData _theme = ThemeStyle.getTheme(viewService.context);
  var _d = state.selectMdeia;
  Widget _child = _d == null
      ? Shimmer.fromColors(
          baseColor: _theme.primaryColorDark,
          highlightColor: _theme.primaryColorLight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: Adapt.px(45),
                width: Adapt.px(400),
                color: Colors.grey[200],
              ),
              SizedBox(
                height: Adapt.px(30),
              ),
              Container(
                height: Adapt.px(24),
                color: Colors.grey[200],
              ),
              SizedBox(
                height: Adapt.px(8),
              ),
              Container(
                height: Adapt.px(24),
                color: Colors.grey[200],
              ),
              SizedBox(
                height: Adapt.px(8),
              ),
              Container(
                height: Adapt.px(24),
                color: Colors.grey[200],
              ),
              SizedBox(
                height: Adapt.px(8),
              ),
              Container(
                height: Adapt.px(24),
                width: Adapt.px(200),
                color: Colors.grey[200],
              ),
              SizedBox(
                height: Adapt.px(8),
              ),
            ],
          ),
        )
      : Column(
          key: ValueKey(_d),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(_d.name,
                style: TextStyle(
                    fontSize: Adapt.px(45), fontWeight: FontWeight.bold)),
            SizedBox(
              height: Adapt.px(20),
            ),
            Text(_d.genre.split(',')?.join(' / ') ?? ''),
            SizedBox(
              height: Adapt.px(20),
            ),
            Text(
              _d.overwatch ?? '',
              maxLines: 5,
            )
          ],
        );
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: Adapt.px(50)),
    child: AnimatedSwitcher(
      transitionBuilder: (w, a) {
        return SlideTransition(
          position: a.drive(Tween(begin: Offset(0, 0.2), end: Offset.zero)),
          child: FadeTransition(
            opacity: a,
            child: w,
          ),
        );
      },
      duration: Duration(milliseconds: 300),
      reverseDuration: Duration(milliseconds: 0),
      child: _child,
    ),
  );
}
