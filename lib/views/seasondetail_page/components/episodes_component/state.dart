import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/tvshow_stream_link.dart';
import 'package:movie/models/episodemodel.dart';

class EpisodesState implements Cloneable<EpisodesState> {
  List<Episode> episodes;
  TvShowStreamLinks streamLinks;
  int tvid;

  EpisodesState({
    this.episodes,
    this.tvid,
    this.streamLinks,
  });

  @override
  EpisodesState clone() {
    return EpisodesState()
      ..episodes = episodes
      ..streamLinks = streamLinks;
  }
}

EpisodesState initState(Map<String, dynamic> args) {
  return EpisodesState();
}
