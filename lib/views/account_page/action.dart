import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/videolist.dart';

//TODO replace with your own action
enum AccountPageAction { action,login,loadData,loadMore}

class AccountPageActionCreator {
  static Action onAction() {
    return const Action(AccountPageAction.action);
  }
   static Action onLogin() {
    return Action(AccountPageAction.login);
  }
  static Action onLoadData(VideoListModel p) {
    return Action(AccountPageAction.loadData,payload: p);
  }

  static Action onLoadMore(List<VideoListResult> p) {
    return Action(AccountPageAction.loadMore,payload: p);
  }
}
