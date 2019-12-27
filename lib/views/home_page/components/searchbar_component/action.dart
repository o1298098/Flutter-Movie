import 'package:fish_redux/fish_redux.dart';

enum SearchBarAction { action, searchBarTapped }

class SearchBarActionCreator {
  static Action onAction() {
    return const Action(SearchBarAction.action);
  }

  static Action onSearchBarTapped() {
    return const Action(SearchBarAction.searchBarTapped);
  }
}
