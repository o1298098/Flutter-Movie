import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(SeasonDetailPageState state, Dispatch dispatch, ViewService viewService) {
  var adapter=viewService.buildAdapter();
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      brightness: Brightness.light,
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: false,
      title: Text('Season Detail',style: TextStyle(color: Colors.black),),
    ),
    body: ListView.builder(
      itemBuilder: adapter.itemBuilder,
      itemCount: adapter.itemCount,
    ),
  );
}
