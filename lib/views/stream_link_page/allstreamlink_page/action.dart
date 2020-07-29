import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/base_movie.dart';
import 'package:movie/models/base_api_model/base_tvshow.dart';
import 'package:movie/models/sort_condition.dart';

enum AllStreamLinkPageAction {
  action,
  initMovieList,
  initTvShowList,
  loadMoreMovies,
  loadMoreTvShows,
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
      int id, String bgpic, String title, String posterpic) {
    return Action(AllStreamLinkPageAction.gridCellTapped,
        payload: [id, bgpic, title, posterpic]);
  }

  static Action initMovieList(BaseMovieModel d) {
    return Action(AllStreamLinkPageAction.initMovieList, payload: d);
  }

  static Action initTvShowList(BaseTvShowModel d) {
    return Action(AllStreamLinkPageAction.initTvShowList, payload: d);
  }

  static Action loadMoreMovie(BaseMovieModel d) {
    return Action(AllStreamLinkPageAction.loadMoreMovies, payload: d);
  }

  static Action loadMoreTvShows(BaseTvShowModel d) {
    return Action(AllStreamLinkPageAction.loadMoreTvShows, payload: d);
  }

  static Action openMenu() {
    return Action(AllStreamLinkPageAction.openMenu);
  }

  static Action search(String query) {
    return Action(AllStreamLinkPageAction.search, payload: query);
  }
}
