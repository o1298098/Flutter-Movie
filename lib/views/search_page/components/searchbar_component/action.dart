import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/models/searchresult.dart';

//TODO replace with your own action
enum SearchBarAction { action,textChanged,setSearchResult,setFocus }

class SearchBarActionCreator {
  static Action onAction() {
    return const Action(SearchBarAction.action);
  }
  static Action onTextChanged(String keywork) {
    return Action(SearchBarAction.textChanged,payload: keywork);
  }
   static Action onSetSearchResult(SearchResultModel r) {
    return Action(SearchBarAction.setSearchResult,payload: r);
  }
  static Action onSetFocus(FocusNode r) {
    return Action(SearchBarAction.setFocus,payload: r);
  }
}
