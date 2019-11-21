import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/tvshow_stream_link.dart';

//TODO replace with your own action
enum TvShowLiveStreamPageAction {
  action,
  setStreamLinks,
  episodeCellTapped,
  episodeChanged
}

class TvShowLiveStreamPageActionCreator {
  static Action onAction() {
    return const Action(TvShowLiveStreamPageAction.action);
  }

  static Action setStreamLinks(TvShowStreamLinks d) {
    return Action(TvShowLiveStreamPageAction.setStreamLinks, payload: d);
  }

  static Action episodeCellTapped(int episode) {
    return Action(TvShowLiveStreamPageAction.episodeCellTapped,
        payload: episode);
  }

  static Action episodeChanged(int episode) {
    return Action(TvShowLiveStreamPageAction.episodeChanged, payload: episode);
  }
}
