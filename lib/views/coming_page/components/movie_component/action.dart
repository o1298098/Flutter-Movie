import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/video_list.dart';

enum MovieListAction { action, cellTapped }

class MovieListActionCreator {
  static Action onAction() {
    return const Action(MovieListAction.action);
  }

  static Action cellTapped(VideoListResult d) {
    return Action(MovieListAction.cellTapped, payload: d);
  }
}
