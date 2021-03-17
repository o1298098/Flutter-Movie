import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/enums/genres.dart';
import 'package:movie/models/sort_condition.dart';
import '../../state.dart';

class FilterState implements Cloneable<FilterState> {
  bool isMovie = true;
  bool sortDesc = true;
  double lVote = 0.0;
  double rVote = 10.0;
  SortCondition selectedSort;
  TextEditingController keyWordController;
  List<SortCondition> sortTypes = [
    SortCondition(name: 'Popularity', isSelected: true, value: 'popularity'),
    SortCondition(
        name: 'Release Date', isSelected: false, value: 'release_date'),
    SortCondition(name: 'Title', isSelected: false, value: 'original_title'),
    SortCondition(name: 'Rating', isSelected: false, value: 'vote_average'),
    SortCondition(name: 'Vote Count', isSelected: false, value: 'vote_count'),
  ];
  List<SortCondition> movieGenres = []
    ..addAll(Genres.instance.movieList.keys.map((i) {
      return SortCondition(
          name: Genres.instance.movieList[i], isSelected: false, value: i);
    }).toList());
  List<SortCondition> tvGenres = []
    ..addAll(Genres.instance.tvList.keys.map((i) {
      return SortCondition(
          name: Genres.instance.tvList[i], isSelected: false, value: i);
    }).toList());
  List<SortCondition> currentGenres = [];
  String keywords;

  @override
  FilterState clone() {
    return FilterState()
      ..sortTypes = sortTypes
      ..lVote = lVote
      ..rVote = rVote
      ..selectedSort = selectedSort
      ..isMovie = isMovie
      ..sortDesc = sortDesc
      ..movieGenres = movieGenres
      ..tvGenres = tvGenres
      ..keywords = keywords
      ..currentGenres = currentGenres
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
