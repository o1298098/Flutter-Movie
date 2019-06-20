import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie/actions/Adapt.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    SearchBarState state, Dispatch dispatch, ViewService viewService) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
      .copyWith(statusBarBrightness: Brightness.light));
  return Container(
    margin: EdgeInsets.fromLTRB(
        Adapt.px(30), Adapt.px(30), Adapt.px(30), Adapt.px(10)),
    padding: EdgeInsets.only(left: Adapt.px(30), right: Adapt.px(30)),
    height: Adapt.px(80),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(Adapt.px(40)),
      color: Colors.grey[200],
    ),
    child: TextField(
        keyboardAppearance: Brightness.light,
        cursorColor: Colors.grey,
        decoration: new InputDecoration(
            hintText: "Search for a movie,tv show,person",
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey,
            ),
            enabledBorder: new UnderlineInputBorder(
                borderSide: new BorderSide(color: Colors.transparent)),
            focusedBorder: new UnderlineInputBorder(
                borderSide: new BorderSide(color: Colors.transparent)))),
  );
}
