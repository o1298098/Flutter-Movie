import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/enums/screenshot_type.dart';
import 'package:movie/models/listdetailmode.dart';
import 'package:movie/models/sortcondition.dart';
import 'package:movie/models/videolist.dart';

//TODO replace with your own action
enum ListDetailPageAction { action,setListDetail,cellTapped,loadMore,sortChanged,setSort,screenShot}

class ListDetailPageActionCreator {
  static Action onAction() {
    return const Action(ListDetailPageAction.action);
  }
  static Action setListDetail(ListDetailModel d) {
    return Action(ListDetailPageAction.setListDetail,payload: d);
  }
  static Action cellTapped(VideoListResult result) {
    return Action(ListDetailPageAction.cellTapped,payload: result);
  }
  static Action loadMore(ListDetailModel d) {
    return Action(ListDetailPageAction.loadMore,payload: d);
  }
  static Action sortChanged(SortCondition d) {
    return Action(ListDetailPageAction.sortChanged,payload: d);
  }
  static Action setSort(SortCondition d) {
    return Action(ListDetailPageAction.setSort,payload: d);
  }
  static Action screenShot(ScreenShotType type) {
    return Action(ListDetailPageAction.screenShot,payload: type);
  }
}
