import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/base_movie.dart';
import 'package:movie/models/enums/media_type.dart';
import 'package:movie/models/sortcondition.dart';

//TODO replace with your own action
enum AllStreamLinkPageAction {
  action,
  initStreamList,
  loadMore,
  openMenu,
  search,
  gridCellTapped,
  sortChanged,
}

class AllStreamLinkPageActionCreator {
  static Action onAction() {
    return const Action(AllStreamLinkPageAction.action);
  }

  static Action sortChanged(SortCondition sortCondition) {
    return Action(AllStreamLinkPageAction.sortChanged, payload: sortCondition);
  }

  static Action gridCellTapped(
      int id, String bgpic, String title, String posterpic, MediaType type) {
    return Action(AllStreamLinkPageAction.gridCellTapped,
        payload: [id, bgpic, title, posterpic, type]);
  }

  static Action initStreamList(BaseMovieModel d) {
    return Action(AllStreamLinkPageAction.initStreamList, payload: d);
  }

  static Action loadMore(BaseMovieModel d) {
    return Action(AllStreamLinkPageAction.loadMore, payload: d);
  }

  static Action openMenu() {
    return Action(AllStreamLinkPageAction.openMenu);
  }

  static Action search(String query) {
    return Action(AllStreamLinkPageAction.search, payload: query);
  }
}
