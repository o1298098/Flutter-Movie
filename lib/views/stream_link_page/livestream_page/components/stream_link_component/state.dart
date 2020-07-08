import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/movie_stream_link.dart';
import 'package:movie/views/stream_link_page/livestream_page/state.dart';

class StreamLinkState implements Cloneable<StreamLinkState> {
  List<MovieStreamLink> streamLinks;
  String streamAddress;
  @override
  StreamLinkState clone() {
    return StreamLinkState()
      ..streamLinks = streamLinks
      ..streamAddress = streamAddress;
  }
}

class StreamLinkConnector extends ConnOp<LiveStreamPageState, StreamLinkState> {
  @override
  StreamLinkState get(LiveStreamPageState state) {
    StreamLinkState mstate = StreamLinkState();
    mstate.streamLinks = state.streamLinks ?? [];
    mstate.streamAddress = state.streamAddress;
    return mstate;
  }
}
