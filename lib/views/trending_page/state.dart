import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:movie/models/enums/media_type.dart';
import 'package:movie/models/searchresult.dart';
import 'package:movie/models/sortcondition.dart';

import 'components/trendingcell_component/state.dart';

class TrendingPageState extends MutableSource
    implements Cloneable<TrendingPageState> {
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
      ..isToday = isToday;
  }

  @override
  Object getItemData(int index) =>
      TrendingCellState(cellData: trending.results[index], index: index);

  @override
  String getItemType(int index) => 'trendingCell';

  @override
  int get itemCount => trending?.results?.length ?? 0;

  @override
  void setItemData(int index, Object data) {}
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
