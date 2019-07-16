import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/episodemodel.dart';

//TODO replace with your own action
enum EpisodeDetailPageAction { action,updateEpisodeDetail }

class EpisodeDetailPageActionCreator {
  static Action onAction() {
    return const Action(EpisodeDetailPageAction.action);
  }
  static Action onUpdateEpisodeDetail(Episode p) {
    return Action(EpisodeDetailPageAction.updateEpisodeDetail,payload: p);
  }
}
