import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/episodemodel.dart';
import 'package:movie/models/seasondetail.dart';
import 'package:movie/models/tvdetail.dart';

enum SeasonLinkPageAction {
  action,
  getSeasonDetial,
  updateSeason,
  episodeCellTapped
}

class SeasonLinkPageActionCreator {
  static Action onAction() {
    return const Action(SeasonLinkPageAction.action);
  }

  static Action getSeasonDetial(Season d) {
    return Action(SeasonLinkPageAction.getSeasonDetial, payload: d);
  }

  static Action updateSeason(TVDetailModel d) {
    return Action(SeasonLinkPageAction.updateSeason, payload: d);
  }

  static Action onEpisodeCellTapped(Episode d) {
    return Action(SeasonLinkPageAction.episodeCellTapped, payload: d);
  }
}
