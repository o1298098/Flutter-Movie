import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/generated/i18n.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    SearchBarState state, Dispatch dispatch, ViewService viewService) {
  return GestureDetector(
    onTap: () => dispatch(SearchBarActionCreator.onSearchBarTapped()),
    child: Hero(
      tag: 'searchbar',
      child: Material(
        color: Colors.transparent,
        child: Container(
            padding: EdgeInsets.only(left: Adapt.px(30), right: Adapt.px(30)),
            height: Adapt.px(80),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Adapt.px(40)),
              color: Colors.grey[200],
            ),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: Adapt.px(20),
                ),
                Text(
                  I18n.of(viewService.context).searchbartxt,
                  style: TextStyle(color: Colors.grey, fontSize: Adapt.px(28)),
                )
              ],
            )
            /*TextField(
        keyboardAppearance: Brightness.light,
        cursorColor: Colors.grey,
        decoration: new InputDecoration(
            hintText: I18n.of(viewService.context).searchbartxt,
            hintStyle: TextStyle(color: Colors.grey,fontSize: Adapt.px(28)),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey,
            ),
            enabledBorder: new UnderlineInputBorder(
                borderSide: new BorderSide(color: Colors.transparent)),
            focusedBorder: new UnderlineInputBorder(
                borderSide: new BorderSide(color: Colors.transparent)))),*/
            ),
      ),
    ),
  );
}
