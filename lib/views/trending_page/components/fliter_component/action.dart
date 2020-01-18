import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/enums/media_type.dart';
import 'package:movie/models/searchresult.dart';
import 'package:movie/models/sortcondition.dart';

enum FliterAction {
  action,
  dateChanged,
  mediaTypeChanged,
  updateList,
  updateDate,
  updateMediaType
}

class FliterActionCreator {
  static Action onAction() {
    return const Action(FliterAction.action);
  }

  static Action dateChanged(bool b) {
    return Action(FliterAction.dateChanged, payload: b);
  }

  static Action mediaTypeChanged(SortCondition sortCondition) {
    return Action(FliterAction.mediaTypeChanged, payload: sortCondition);
  }

  static Action updateList(SearchResultModel d) {
    return Action(FliterAction.updateList, payload: d);
  }

  static Action updateDate(bool b) {
    return Action(FliterAction.updateDate, payload: b);
  }

  static Action updateMediaType(
      List<SortCondition> sortConditions, MediaType selectType) {
    return Action(FliterAction.updateMediaType,
        payload: [sortConditions, selectType]);
  }
}
