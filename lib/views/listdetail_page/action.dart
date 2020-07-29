import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/user_list_detail.dart';
import 'package:movie/models/enums/screenshot_type.dart';
import 'package:movie/models/list_detail_mode.dart';
import 'package:movie/models/sort_condition.dart';

enum ListDetailPageAction {
  action,
  setListDetail,
  cellTapped,
  loadMore,
  sortChanged,
  setSort,
  screenShot,
  showShareCard,
}

class ListDetailPageActionCreator {
  static Action onAction() {
    return const Action(ListDetailPageAction.action);
  }

  static Action showShareCard() {
    return const Action(ListDetailPageAction.showShareCard);
  }

  static Action setListDetail(UserListDetailModel d) {
    return Action(ListDetailPageAction.setListDetail, payload: d);
  }

  static Action cellTapped(UserListDetail result) {
    return Action(ListDetailPageAction.cellTapped, payload: result);
  }

  static Action loadMore(ListDetailModel d) {
    return Action(ListDetailPageAction.loadMore, payload: d);
  }

  static Action sortChanged(SortCondition d) {
    return Action(ListDetailPageAction.sortChanged, payload: d);
  }

  static Action setSort(SortCondition d) {
    return Action(ListDetailPageAction.setSort, payload: d);
  }

  static Action screenShot(ScreenShotType type) {
    return Action(ListDetailPageAction.screenShot, payload: type);
  }
}
