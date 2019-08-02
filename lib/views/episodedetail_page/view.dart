import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/enums/imagesize.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    EpisodeDetailPageState state, Dispatch dispatch, ViewService viewService) {
  var adapter=viewService.buildAdapter();
  var d = state.episode;
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      elevation: 0.0,
      backgroundColor: Colors.white,
      brightness: Brightness.light,
      iconTheme: IconThemeData(color: Colors.black),
      title: Text(d.name,style:TextStyle(color:Colors.black)),
    ),
    body: Container(
        height: Adapt.screenH(),
        child: ListView.builder(
          itemBuilder: adapter.itemBuilder,
          itemCount: adapter.itemCount,
        )),
  );
}
