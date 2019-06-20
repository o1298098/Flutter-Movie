import 'package:fish_redux/fish_redux.dart';

import '../../state.dart';

class SearchBarState implements Cloneable<SearchBarState> {
 
  String keyword='';
  @override
  SearchBarState clone() {
    return SearchBarState();
  }
}

SearchBarState initSearchBarState(Map<String, dynamic> args) {
  return SearchBarState();
}

class SearchBarConnector
    extends ConnOp<HomePageState, SearchBarState> {
  @override
  SearchBarState get(HomePageState state) {
    SearchBarState mstate = SearchBarState();
    return mstate;
  }
}