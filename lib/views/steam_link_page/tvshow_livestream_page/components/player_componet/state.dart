import 'package:chewie/chewie.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:movie/views/steam_link_page/tvshow_livestream_page/state.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TvPlayerState implements Cloneable<TvPlayerState> {
  String streamLinkTypeName;
  String streamAddress;
  ChewieController chewieController;
  YoutubePlayerController youtubePlayerController;
  @override
  TvPlayerState clone() {
    return TvPlayerState()
      ..chewieController = chewieController
      ..youtubePlayerController = youtubePlayerController
      ..streamAddress = streamAddress
      ..streamLinkTypeName = streamLinkTypeName;
  }
}

class TvPlayerConnector
    extends ConnOp<TvShowLiveStreamPageState, TvPlayerState> {
  @override
  TvPlayerState get(TvShowLiveStreamPageState state) {
    TvPlayerState substate = new TvPlayerState();
    substate.chewieController = state.chewieController;
    substate.youtubePlayerController = state.youtubePlayerController;
    substate.streamAddress = state.streamAddress;
    substate.streamLinkTypeName = state.streamLinkType?.name ?? '';
    return substate;
  }
}
