import 'package:fish_redux/fish_redux.dart';
import 'package:movie/views/stream_link_page/livestream_page/state.dart';

class LoadingState implements Cloneable<LoadingState> {
  bool loading;
  @override
  LoadingState clone() {
    return LoadingState()..loading = loading;
  }
}

class LoadingConnector extends ConnOp<LiveStreamPageState, LoadingState> {
  @override
  LoadingState get(LiveStreamPageState state) {
    LoadingState mstate = LoadingState();
    mstate.loading = state.loading;
    return mstate;
  }
}
