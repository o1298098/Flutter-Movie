import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/models.dart';
import 'package:movie/views/stream_link/movie_livestream_page/components/bottom_panel_component/state.dart';

class StreamLinkFilterState implements Cloneable<StreamLinkFilterState> {
  MovieStreamLinks streamLinks;
  MovieStreamLink selectedLink;
  @override
  StreamLinkFilterState clone() {
    return StreamLinkFilterState()
      ..streamLinks = streamLinks
      ..selectedLink = selectedLink;
  }
}

class StreamLinkFilterConnector
    extends ConnOp<BottomPanelState, StreamLinkFilterState> {
  @override
  StreamLinkFilterState get(BottomPanelState state) {
    StreamLinkFilterState mstate = StreamLinkFilterState();
    mstate.streamLinks = state.streamLinks;
    mstate.selectedLink = state.selectedLink;
    return mstate;
  }

  @override
  void set(BottomPanelState state, StreamLinkFilterState subState) {
    state.selectedLink = subState.selectedLink;
    state.streamLinks = subState.streamLinks;
  }
}
