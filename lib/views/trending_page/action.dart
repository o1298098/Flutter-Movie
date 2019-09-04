import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/enums/media_type.dart';
import 'package:movie/models/searchresult.dart';
import 'package:movie/models/sortcondition.dart';

//TODO replace with your own action
enum TrendingPageAction {
  action,
  showFilter,
  setMediaType,
  dateChanged,
  mediaTypeChanged,
  updateList
}

class TrendingPageActionCreator {
  static Action onAction() {
    return const Action(TrendingPageAction.action);
  }

  static Action showFilter() {
    return const Action(TrendingPageAction.showFilter);
  }

  static Action dateChanged(bool b) {
    return Action(TrendingPageAction.dateChanged, payload: b);
  }

  static Action setMediaType(MediaType t) {
    return Action(TrendingPageAction.setMediaType, payload: t);
  }

  static Action mediaTypeChanged(SortCondition t) {
    return Action(TrendingPageAction.mediaTypeChanged, payload: t);
  }

  static Action updateList(SearchResultModel d) {
    return Action(TrendingPageAction.updateList, payload: d);
  }
}
