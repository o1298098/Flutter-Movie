import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/episodemodel.dart';

enum EpisodeLiveStreamAction { action, episodeTapped, setSelectedEpisode }

class EpisodeLiveStreamActionCreator {
  static Action episodeTapped(Episode episode) {
    return Action(EpisodeLiveStreamAction.episodeTapped, payload: episode);
  }

  static Action setSelectedEpisode(Episode episode) {
    return Action(EpisodeLiveStreamAction.setSelectedEpisode, payload: episode);
  }
}
