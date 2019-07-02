import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/tvdetail.dart';

//TODO replace with your own action
enum TVCellAction { action,loadSeason}

class TVCellActionCreator {
  static Action onAction() {
    return const Action(TVCellAction.action);
  }
  static Action onLoadSeason(TVDetailModel d) {
    return Action(TVCellAction.loadSeason,payload: d);
  }
}
