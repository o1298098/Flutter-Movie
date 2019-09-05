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
  updateList,
  loadMore,
  cellTapped
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

  static Action setMediaType(MediaType mediaType) {
    return Action(TrendingPageAction.setMediaType, payload: mediaType);
  }

  static Action mediaTypeChanged(SortCondition sortCondition) {
    return Action(TrendingPageAction.mediaTypeChanged, payload: sortCondition);
  }

  static Action updateList(SearchResultModel d) {
    return Action(TrendingPageAction.updateList, payload: d);
  }

  static Action loadMore(SearchResultModel d) {
    return Action(TrendingPageAction.loadMore, payload: d);
  }

  static Action cellTapped(SearchResult d) {
    return Action(TrendingPageAction.cellTapped, payload: d);
  }
}
