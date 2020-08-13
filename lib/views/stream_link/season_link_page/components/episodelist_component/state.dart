import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/episode_model.dart';
import 'package:movie/models/season_detail.dart';
import 'package:movie/views/stream_link/season_link_page/components/episode_component/state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EpisodeListState extends MutableSource
    implements Cloneable<EpisodeListState> {
  Season season;
  List<Episode> episodes;
  int tvid;
  String name;

  SharedPreferences preferences;
  EpisodeListState(
      {this.episodes, this.season, this.preferences, this.tvid, this.name});
  @override
  EpisodeListState clone() {
    return EpisodeListState()
      ..episodes = episodes
      ..season = season
      ..tvid = tvid
      ..name = name
      ..preferences = preferences;
  }

  EpisodeListState initState(Map<String, dynamic> args) {
    var state = EpisodeListState();
    return state;
  }

  @override
  Object getItemData(int index) => EpisodeState(
      episode: episodes[index], playState: episodes[index].playState);

  @override
  String getItemType(int index) => 'episode';

  @override
  int get itemCount => episodes?.length ?? 0;

  @override
  void setItemData(int index, Object data) {
    EpisodeState _e = data;
    episodes[index] = _e.episode;
  }
}
