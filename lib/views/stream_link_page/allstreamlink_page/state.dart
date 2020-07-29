import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/base_api_model/base_movie.dart';
import 'package:movie/models/base_api_model/base_tvshow.dart';
import 'package:movie/models/enums/media_type.dart';
import 'package:movie/models/sort_condition.dart';

class AllStreamLinkPageState implements Cloneable<AllStreamLinkPageState> {
  BaseMovieModel movieList;
  BaseTvShowModel tvList;
  ScrollController scrollController;
  GlobalKey<ScaffoldState> scaffoldKey;
  AnimationController animationController;
  List<SortCondition> sortTypes;
  String orderBy;
  bool desc;
  bool loading;
  MediaType mediaType;

  @override
  AllStreamLinkPageState clone() {
    return AllStreamLinkPageState()
      ..movieList = movieList
      ..tvList = tvList
      ..scrollController = scrollController
      ..scaffoldKey = scaffoldKey
      ..animationController = animationController
      ..sortTypes = sortTypes
      ..orderBy = orderBy
      ..desc = desc
      ..loading = loading
      ..mediaType = mediaType;
  }
}

AllStreamLinkPageState initState(Map<String, dynamic> args) {
  AllStreamLinkPageState state = new AllStreamLinkPageState();
  state.scaffoldKey = GlobalKey<ScaffoldState>(debugLabel: 'allStreamLinkPage');
  state.mediaType = args['type'] ?? MediaType.movie;
  state.orderBy = 'updateTime';
  state.desc = true;
  state.loading = false;
  state.sortTypes = [
    SortCondition(
        isSelected: true, name: 'UpdateTime Desc', value: ['updateTime', true]),
    SortCondition(
        isSelected: false,
        name: 'UpdateTime Asc',
        value: ['updateTime', false]),
    SortCondition(isSelected: false, name: 'Name Desc', value: ['name', true]),
    SortCondition(isSelected: false, name: 'Name Asc', value: ['name', false]),
  ];
  return state;
}
