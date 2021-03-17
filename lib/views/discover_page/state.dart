import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie/globalbasestate/state.dart';
import 'package:movie/models/app_user.dart';
import 'package:movie/models/sort_condition.dart';
import 'package:movie/models/video_list.dart';
import 'package:movie/views/discover_page/components/filter_component/state.dart';

import 'components/movicecell_component/state.dart';

class DiscoverPageState extends MutableSource
    implements GlobalBaseState, Cloneable<DiscoverPageState> {
  FilterState filterState;
  VideoListModel videoListModel;
  ScrollController scrollController;
  GlobalKey stackKey;
  GlobalKey<ScaffoldState> scaffoldKey;
  SortCondition selectedSort;
  bool sortDesc;
  bool isMovie;
  bool isbusy;
  double lVote;
  double rVote;
  List<SortCondition> currentGenres = [];
  @override
  DiscoverPageState clone() {
    return DiscoverPageState()
      ..filterState = filterState
      ..videoListModel = videoListModel
      ..selectedSort = selectedSort
      ..scrollController = scrollController
      ..scaffoldKey = scaffoldKey
      ..stackKey = stackKey
      ..lVote = lVote
      ..rVote = rVote
      ..sortDesc = sortDesc
      ..isMovie = isMovie
      ..isbusy = isbusy
      ..currentGenres = currentGenres;
  }

  @override
  Color themeColor;

  @override
  Locale locale;

  @override
  AppUser user;

  @override
  Object getItemData(int index) => VideoCellState()
    ..videodata = videoListModel?.results[index]
    ..isMovie = isMovie ?? true;

  @override
  String getItemType(int index) => 'moviecell';

  @override
  int get itemCount => videoListModel?.results?.length ?? 0;

  @override
  void setItemData(int index, Object data) {}
}

DiscoverPageState initState(Map<String, dynamic> args) {
  final DiscoverPageState state = DiscoverPageState();
  state.filterState = new FilterState();
  state.filterState.selectedSort = state.filterState.sortTypes[0];
  state.selectedSort = state.filterState.sortTypes[0];
  state.currentGenres = state.filterState.currentGenres;
  state.scaffoldKey = GlobalKey();
  state.stackKey = GlobalKey();
  state.sortDesc = true;
  state.isMovie = true;
  state.isbusy = false;
  state.lVote = 0.0;
  state.rVote = 10.0;
  state.videoListModel =VideoListModel.fromParams(results: []);
  return state;
}
