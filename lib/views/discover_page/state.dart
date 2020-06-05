import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gzx_dropdown_menu/gzx_dropdown_menu.dart';
import 'package:movie/globalbasestate/state.dart';
import 'package:movie/models/app_user.dart';
import 'package:movie/models/sortcondition.dart';
import 'package:movie/models/videolist.dart';
import 'package:movie/views/discover_page/components/filter_component/state.dart';

import 'components/movicecell_component/state.dart';

class DiscoverPageState extends MutableSource
    implements GlobalBaseState, Cloneable<DiscoverPageState> {
  FilterState filterState;
  VideoListModel videoListModel;
  ScrollController scrollController;
  GlobalKey stackKey;
  GlobalKey<ScaffoldState> scaffoldKey;
  GZXDropdownMenuController dropdownMenuController;
  SortCondition selectedSort;
  bool sortDesc;
  bool isMovie;
  bool isbusy;
  @override
  DiscoverPageState clone() {
    return DiscoverPageState()
      ..filterState = filterState
      ..videoListModel = videoListModel
      ..selectedSort = selectedSort
      ..scrollController = scrollController
      ..dropdownMenuController = dropdownMenuController
      ..scaffoldKey = scaffoldKey
      ..stackKey = stackKey
      ..sortDesc = sortDesc
      ..isMovie = isMovie
      ..isbusy = isbusy;
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
  state.scaffoldKey = GlobalKey();
  state.stackKey = GlobalKey();
  state.sortDesc = true;
  state.isMovie = true;
  state.isbusy = false;
  state.dropdownMenuController = GZXDropdownMenuController();
  state.videoListModel =
      new VideoListModel.fromParams(results: List<VideoListResult>());
  return state;
}
