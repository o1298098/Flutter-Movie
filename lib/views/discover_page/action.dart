import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/videolist.dart';

//TODO replace with your own action
enum DiscoverPageAction { 
  loadData,
  action,
  sortChanged,
  videoCellTapped,
  refreshData,
  loadMore,
  busyChanged,
}

class DiscoverPageActionCreator {
  static Action onAction() {
    return const Action(DiscoverPageAction.action);
  }
  static Action onSortChanged(String s) {
    return Action(DiscoverPageAction.sortChanged,payload: s);
  }
  static Action onLoadData(VideoListModel p) {
    return Action(DiscoverPageAction.loadData,payload: p);
  }
   static Action onRefreshData() {
    return const Action(DiscoverPageAction.refreshData);
  }
  static Action onLoadMore(List<VideoListResult> p) {
    return Action(DiscoverPageAction.loadMore,payload: p);
  }
  static Action onVideoCellTapped(int p,String backpic) {
    return Action(DiscoverPageAction.videoCellTapped,payload: [p,backpic]);
  }
  static Action onBusyChanged(bool p) {
    return Action(DiscoverPageAction.busyChanged,payload: p);
  }
}
