import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/video_list.dart';

enum ComingPageAction {
  action,
  initMoviesComing,
  loadMore,
  initTVComing,
  filterChanged
}

class ComingPageActionCreator {
  static Action onAction() {
    return const Action(ComingPageAction.action);
  }

  static Action onInitMoviesComing(VideoListModel d) {
    return Action(ComingPageAction.initMoviesComing, payload: d);
  }

  static Action onInitTVComing(VideoListModel d) {
    return Action(ComingPageAction.initTVComing, payload: d);
  }

  static Action onLoadMore(VideoListModel d) {
    return Action(ComingPageAction.loadMore, payload: d);
  }

  static Action onFilterChanged(bool b) {
    return Action(ComingPageAction.filterChanged, payload: b);
  }
}
