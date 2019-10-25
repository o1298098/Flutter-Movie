import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/videolist.dart';

//TODO replace with your own action
enum WatchlistPageAction {
  action,
  setTVShowSnapshot,
  widthChanged,
  swiperChanged,
  swiperCellTapped,
  setMovieSnapshot,
}

class WatchlistPageActionCreator {
  static Action onAction() {
    return const Action(WatchlistPageAction.action);
  }

  static Action setTVShowSnapshot(QuerySnapshot d) {
    return Action(WatchlistPageAction.setTVShowSnapshot, payload: d);
  }

  static Action widthChanged(bool d) {
    return Action(WatchlistPageAction.widthChanged, payload: d);
  }

  static Action swiperChanged(DocumentSnapshot d) {
    return Action(WatchlistPageAction.swiperChanged, payload: d);
  }

  static Action swiperCellTapped() {
    return const Action(WatchlistPageAction.swiperCellTapped);
  }

  static Action setMovieSnapshot(QuerySnapshot d) {
    return Action(WatchlistPageAction.setMovieSnapshot, payload: d);
  }
}
