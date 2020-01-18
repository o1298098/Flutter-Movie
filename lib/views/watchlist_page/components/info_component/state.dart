import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/user_media.dart';
import 'package:movie/views/watchlist_page/state.dart';

class InfoState implements Cloneable<InfoState> {
  UserMedia selectMdeia;
  @override
  InfoState clone() {
    return InfoState()..selectMdeia = selectMdeia;
  }
}

class InfoConnector extends ConnOp<WatchlistPageState, InfoState> {
  @override
  InfoState get(WatchlistPageState state) {
    final InfoState mstate = InfoState();
    mstate.selectMdeia = state.selectMdeia;
    return mstate;
  }
}
