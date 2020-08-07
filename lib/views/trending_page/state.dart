import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:movie/globalbasestate/state.dart';
import 'package:movie/models/app_user.dart';
import 'package:movie/models/enums/media_type.dart';
import 'package:movie/models/search_result.dart';
import 'package:movie/models/sort_condition.dart';

import 'components/trendingcell_component/state.dart';

class TrendingPageState extends MutableSource
    implements GlobalBaseState, Cloneable<TrendingPageState> {
  SearchResultModel trending;
  ScrollController controller;
  AnimationController animationController;
  AnimationController refreshController;
  List<SortCondition> mediaTypes;
  MediaType selectMediaType;
  bool isToday;

  @override
  TrendingPageState clone() {
    return TrendingPageState()
      ..trending = trending
      ..controller = controller
      ..animationController = animationController
      ..refreshController = refreshController
      ..mediaTypes = mediaTypes
      ..selectMediaType = selectMediaType
      ..isToday = isToday
      ..user = user;
  }

  @override
  Object getItemData(int index) => TrendingCellState(
        cellData: trending.results[index],
        index: index,
        user: user,
        liked: trending.results[index].liked ?? false,
      );

  @override
  String getItemType(int index) => 'trendingCell';

  @override
  int get itemCount => trending?.results?.length ?? 0;

  @override
  void setItemData(int index, Object data) {
    //TrendingCellState _trendingState = data as TrendingCellState;
    //trending.results[index].liked = _trendingState.liked;
  }

  @override
  Locale locale;

  @override
  Color themeColor;

  @override
  AppUser user;
}

TrendingPageState initState(Map<String, dynamic> args) {
  TrendingPageState state = TrendingPageState();
  state.trending = args['data'];
  state.isToday = true;
  state.selectMediaType = MediaType.all;
  state.mediaTypes = [
    SortCondition(isSelected: true, name: 'All', value: MediaType.all),
    SortCondition(isSelected: false, name: 'Movie', value: MediaType.movie),
    SortCondition(isSelected: false, name: 'TV Shows', value: MediaType.tv),
    SortCondition(isSelected: false, name: 'Person', value: MediaType.person),
  ];
  return state;
}
