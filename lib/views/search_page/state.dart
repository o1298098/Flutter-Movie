import 'package:fish_redux/fish_redux.dart';

class SearchPageState implements Cloneable<SearchPageState> {

  @override
  SearchPageState clone() {
    return SearchPageState();
  }
}

SearchPageState initState(Map<String, dynamic> args) {
  return SearchPageState();
}
