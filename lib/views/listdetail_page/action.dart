import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/listdetailmode.dart';
import 'package:movie/models/videolist.dart';

//TODO replace with your own action
enum ListDetailPageAction { action,setListDetail,cellTapped,loadMore}

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
}
