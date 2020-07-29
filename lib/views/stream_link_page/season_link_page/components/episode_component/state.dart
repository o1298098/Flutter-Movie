import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/episode_model.dart';

class EpisodeState implements Cloneable<EpisodeState> {
  Episode episode;
  bool playState;

  EpisodeState({this.episode, this.playState});
  @override
  EpisodeState clone() {
    return EpisodeState();
  }
}

EpisodeState initState(Map<String, dynamic> args) {
  return EpisodeState();
}
