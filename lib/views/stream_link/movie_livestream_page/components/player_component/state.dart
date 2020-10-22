import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/app_user.dart';
import 'package:movie/views/stream_link/movie_livestream_page/state.dart';

class PlayerState implements Cloneable<PlayerState> {
  String playerType;
  String streamLink;
  String background;
  AppUser user;
  int streamLinkId;
  bool useVideoSourceApi;
  bool streamInBrowser;
  bool needAd;
  bool loading;
  @override
  PlayerState clone() {
    return PlayerState()
      ..user = user
      ..playerType = playerType
      ..streamLink = streamLink
      ..background = background
      ..useVideoSourceApi = useVideoSourceApi
      ..streamInBrowser = streamInBrowser
      ..needAd = needAd
      ..loading = loading;
  }
}

class PlayerConnector extends ConnOp<MovieLiveStreamState, PlayerState> {
  @override
  PlayerState get(MovieLiveStreamState state) {
    PlayerState mstate = state.playerState.clone();
    mstate.useVideoSourceApi = state.bottomPanelState.useVideoSourceApi;
    mstate.streamInBrowser = state.bottomPanelState.streamInBrowser ||
        (state.selectedLink?.externalBrowser ?? false);
    mstate.needAd = state.selectedLink?.needAd ?? false;
    mstate.background = state.background;
    mstate.streamLinkId = state.selectedLink?.sid ?? 0;
    mstate.loading = state.loading;
    mstate.user = state.user;
    mstate.playerType =
        state.selectedLink?.streamLinkType?.name ?? 'VideoSourceApi';
    mstate.streamLink = state.selectedLink?.streamLink ??
        'https://moviessources.cf/embed/${state.movieId}';
    return mstate;
  }

  @override
  void set(MovieLiveStreamState state, PlayerState subState) {
    state.playerState = subState;
  }
}
