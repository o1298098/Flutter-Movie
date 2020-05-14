import 'package:fish_redux/fish_redux.dart';
import 'package:movie/views/steam_link_page/tvshow_livestream_page/state.dart';

class LoadingState implements Cloneable<LoadingState> {
  bool loading;
  @override
  LoadingState clone() {
    return LoadingState()..loading = loading;
  }
}

class LoadingConnector extends ConnOp<TvShowLiveStreamPageState, LoadingState> {
  @override
  LoadingState get(TvShowLiveStreamPageState state) {
    LoadingState mstate = LoadingState();
    mstate.loading = state.loading;
    return mstate;
  }
}
