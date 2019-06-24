import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum SearchPageAction { action }

class SearchPageActionCreator {
  static Action onAction() {
    return const Action(SearchPageAction.action);
  }
}
