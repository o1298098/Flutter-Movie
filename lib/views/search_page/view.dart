import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loader_search_bar/loader_search_bar.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/generated/i18n.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    SearchPageState state, Dispatch dispatch, ViewService viewService) {
  var adapter=viewService.buildAdapter();
  return Scaffold(
    backgroundColor: Colors.amber,
    appBar:SearchBar(
    controller: SearchBarController(onCancelSearch: (){Navigator.of(viewService.context).pop();}),
    iconified: false,
    autofocus: true,
    autoActive: AutoActive.on,
    searchHint: I18n.of(viewService.context).searchbartxt,
    defaultBar: AppBar(),
    attrs: SearchBarAttrs(
      textBoxOutlineWidth: 0,
      textBoxBackgroundColor: Colors.grey[200],
      textStyle: TextStyle(fontSize: Adapt.px(28)),
      textBoxOutlineRadius: Adapt.px(40)
    ),
  ) 
    /*AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      elevation: 0.0,
      iconTheme: IconThemeData(color: Colors.black),
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      title: viewService.buildComponent('searchbar'),
      actions: <Widget>[
        Container(
          width: Adapt.px(100),
          height: Adapt.px(50),
          margin: EdgeInsets.symmetric(vertical: Adapt.px(30)),
          child: RaisedButton(
            elevation: 0.0,
            color: Colors.white,
            padding: EdgeInsets.all(0),
            onPressed: () {
              state.focus.unfocus();
              Navigator.of(viewService.context).pop();
            },
            child: Text(
              'Cancel',
              style: TextStyle(fontSize: Adapt.px(26)),
            ),
          ),
        ),
        SizedBox(
          width: Adapt.px(10),
        )
      ],
    )*/,
    body: ListView.builder(
      itemBuilder: adapter.itemBuilder,
      itemCount: adapter.itemCount,
    ),
  );
}