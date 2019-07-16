import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum SearchBarAction { action ,searchBarTapped}

class SearchBarActionCreator {
  static Action onAction() {
    return const Action(SearchBarAction.action);
  }
  static Action onSearchBarTapped() {
    return const Action(SearchBarAction.searchBarTapped);
  }
}
