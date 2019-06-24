import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum FilterAction { action,sortChanged,genresChanged,keywordschanged }

class FilterActionCreator {
  static Action onAction() {
    return Action(FilterAction.action);
  }
  static Action onSortChanged(bool o) {
    return  Action(FilterAction.sortChanged,payload: o);
  }
  static Action onGenresChanged() {
    return  Action(FilterAction.genresChanged);
  }
   static Action onKeyWordsChanged(String s) {
    return  Action(FilterAction.keywordschanged,payload: s);
  }
}
