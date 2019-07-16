
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:movie/models/searchresult.dart';
import '../../state.dart';

class SearchBarState implements Cloneable<SearchBarState> {
SearchResultModel searchResultModel;
FocusNode focus;

  @override
  SearchBarState clone() {
    return 
    SearchBarState()
    ..searchResultModel=searchResultModel
    ..focus=focus;
  }
}

class SearchBarConnector
    extends ConnOp<SearchPageState, SearchBarState> {
  @override
  SearchBarState get(SearchPageState state) {
    SearchBarState mstate = SearchBarState();
    mstate.searchResultModel=state.searchResultModel;
    return mstate;
  }
  @override
  void set(SearchPageState state, SearchBarState subState) {
    state.searchResultModel=subState.searchResultModel;
     state.focus=subState.focus;
  }
}