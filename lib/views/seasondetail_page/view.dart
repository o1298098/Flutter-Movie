import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/generated/i18n.dart';

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
      title: Text(I18n.of(viewService.context).seasonDetail,style: TextStyle(color: Colors.black),),
    ),
    body: ListView.builder(
      itemBuilder: adapter.itemBuilder,
      itemCount: adapter.itemCount,
    ),
  );
}
