import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/video_list.dart';

enum MoreMediaPageAction { action, loadMore, cellTapped }

class MoreMediaPageActionCreator {
  static Action onAction() {
    return const Action(MoreMediaPageAction.action);
  }

  static Action loadMore(VideoListModel list) {
    return Action(MoreMediaPageAction.loadMore, payload: list);
  }

  static Action cellTapped(
      int id, String title, String bgpic, String posterpic) {
    return Action(MoreMediaPageAction.cellTapped,
        payload: [id, title, bgpic, posterpic]);
  }
}
