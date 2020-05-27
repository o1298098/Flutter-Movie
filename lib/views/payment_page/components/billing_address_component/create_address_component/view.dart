import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/style/themestyle.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    CreateAddressState state, Dispatch dispatch, ViewService viewService) {
  return Builder(
    builder: (context) {
      final _theme = ThemeStyle.getTheme(context);
      return Scaffold(
        backgroundColor: _theme.primaryColorDark,
        appBar: AppBar(
          backgroundColor: _theme.primaryColorDark,
          brightness: _theme.brightness,
          iconTheme: _theme.iconTheme,
          elevation: 0.0,
          centerTitle: false,
          title: Text(
            'Create Address',
            style: TextStyle(color: _theme.textTheme.bodyText1.color),
          ),
          actions: [],
        ),
        body: Container(
          margin: EdgeInsets.only(top: Adapt.px(20)),
          padding: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
          decoration: BoxDecoration(
            color: _theme.backgroundColor,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(Adapt.px(60)),
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: Adapt.px(80)),
              _CustomTextField(),
            ],
          ),
        ),
      );
    },
  );
}

class _CustomTextField extends StatelessWidget {
  final String title;
  const _CustomTextField({this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Region', style: TextStyle(fontSize: Adapt.px(30))),
          TextField(),
        ],
      ),
    );
  }
}
