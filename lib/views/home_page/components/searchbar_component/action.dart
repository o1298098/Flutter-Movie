import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum SearchBarAction { action }

class SearchBarActionCreator {
  static Action onAction() {
    return const Action(SearchBarAction.action);
  }
}
