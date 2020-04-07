import 'package:chewie/chewie.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:movie/views/steam_link_page/livestream_page/state.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayerState implements Cloneable<PlayerState> {
  String streamLinkTypeName;
  String streamAddress;
  YoutubePlayerController youtubePlayerController;
  ChewieController chewieController;
  @override
  PlayerState clone() {
    return PlayerState()
      ..streamLinkTypeName = streamLinkTypeName
      ..streamAddress = streamAddress;
  }
}

class PlayerConnector extends ConnOp<LiveStreamPageState, PlayerState> {
  @override
  PlayerState get(LiveStreamPageState state) {
    PlayerState mstate = PlayerState();
    mstate.chewieController = state.chewieController;
    mstate.youtubePlayerController = state.youtubePlayerController;
    mstate.streamAddress = state.streamAddress;
    mstate.streamLinkTypeName = state.streamLinkType?.name ?? '';
    return mstate;
  }
}
