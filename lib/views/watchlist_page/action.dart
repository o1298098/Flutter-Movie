import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/videolist.dart';

//TODO replace with your own action
enum WatchlistPageAction {
  action,
  setMovieList,
  setTVShowList,
  widthChanged,
  swiperChanged,
  swiperCellTapped,
}

class WatchlistPageActionCreator {
  static Action onAction() {
    return const Action(WatchlistPageAction.action);
  }

  static Action setMovieList(VideoListModel d) {
    return Action(WatchlistPageAction.setMovieList, payload: d);
  }

  static Action setTVShowList(VideoListModel d) {
    return Action(WatchlistPageAction.setTVShowList, payload: d);
  }

  static Action widthChanged(bool d) {
    return Action(WatchlistPageAction.widthChanged, payload: d);
  }

  static Action swiperChanged(VideoListResult d) {
    return Action(WatchlistPageAction.swiperChanged, payload: d);
  }

  static Action swiperCellTapped() {
    return const Action(WatchlistPageAction.swiperCellTapped);
  }
}
