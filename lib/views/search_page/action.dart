import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/searchresult.dart';

//TODO replace with your own action
enum SearchPageAction { action ,setSearchResult,setGlobalkey}

class SearchPageActionCreator {
  static Action onAction() {
    return const Action(SearchPageAction.action);
  }
  static Action onSetSearchResult(SearchResultModel r) {
    return Action(SearchPageAction.setSearchResult,payload: r);
  }
  static Action setGlobalkey() {
    return const Action(SearchPageAction.setGlobalkey);
  }
}
