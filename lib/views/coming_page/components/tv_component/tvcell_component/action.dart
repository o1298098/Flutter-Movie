import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/tvshow_detail.dart';
import 'package:movie/models/video_list.dart';

enum TVCellAction { action, loadSeason, cellTapped }

class TVCellActionCreator {
  static Action onAction() {
    return const Action(TVCellAction.action);
  }

  static Action onLoadSeason(TVDetailModel d) {
    return Action(TVCellAction.loadSeason, payload: d);
  }

  static Action cellTapped(VideoListResult d) {
    return Action(TVCellAction.cellTapped, payload: d);
  }
}
