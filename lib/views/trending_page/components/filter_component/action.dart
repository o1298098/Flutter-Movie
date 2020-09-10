import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/enums/media_type.dart';
import 'package:movie/models/search_result.dart';
import 'package:movie/models/sort_condition.dart';

enum FilterAction {
  action,
  dateChanged,
  mediaTypeChanged,
  updateList,
  updateDate,
  updateMediaType
}

class FilterActionCreator {
  static Action onAction() {
    return const Action(FilterAction.action);
  }

  static Action dateChanged(bool b) {
    return Action(FilterAction.dateChanged, payload: b);
  }

  static Action mediaTypeChanged(SortCondition sortCondition) {
    return Action(FilterAction.mediaTypeChanged, payload: sortCondition);
  }

  static Action updateList(SearchResultModel d) {
    return Action(FilterAction.updateList, payload: d);
  }

  static Action updateDate(bool b) {
    return Action(FilterAction.updateDate, payload: b);
  }

  static Action updateMediaType(
      List<SortCondition> sortConditions, MediaType selectType) {
    return Action(FilterAction.updateMediaType,
        payload: [sortConditions, selectType]);
  }
}
