import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/enums/genres.dart';
import 'package:movie/models/sortcondition.dart';
import '../../state.dart';

class FilterState implements Cloneable<FilterState> {
  bool isMovie = true;
  bool sortDesc = true;
  SortCondition selectedSort;
  TextEditingController keyWordController;
  List<SortCondition> sortTypes;
  List<SortCondition> movieGenres = new List<SortCondition>()
    ..addAll(Genres.movieList.keys.map((i) {
      return SortCondition(
          name: Genres.movieList[i], isSelected: false, value: i);
    }).toList());
  List<SortCondition> tvGenres = new List<SortCondition>()
    ..addAll(Genres.tvList.keys.map((i) {
      return SortCondition(name: Genres.tvList[i], isSelected: false, value: i);
    }).toList());
  List<SortCondition> currectGenres = [];
  String keywords;

  @override
  FilterState clone() {
    return FilterState()
      ..sortTypes = sortTypes
      ..selectedSort = selectedSort
      ..isMovie = isMovie
      ..sortDesc = sortDesc
      ..movieGenres = movieGenres
      ..tvGenres = tvGenres
      ..keywords = keywords
      ..currectGenres = currectGenres
      ..keyWordController = keyWordController;
  }
}

class FilterConnector extends ConnOp<DiscoverPageState, FilterState> {
  @override
  FilterState get(DiscoverPageState state) {
    final FilterState filterState = state.filterState;
    return filterState;
  }

  @override
  void set(DiscoverPageState state, FilterState subState) {
    state.filterState = subState;
  }
}
