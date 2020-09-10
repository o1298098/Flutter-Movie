import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/enums/media_type.dart';
import 'package:movie/models/search_result.dart';

enum TrendingPageAction {
  action,
  showFilter,
  setMediaType,
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

  static Action setMediaType(MediaType mediaType) {
    return Action(TrendingPageAction.setMediaType, payload: mediaType);
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
