import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/enums/media_type.dart';
import 'package:movie/models/models.dart';
import 'package:movie/models/people_detail.dart';

enum PeopleDetailPageAction {
  action,
  init,
  setCreditModel,
  showBiography,
  cellTapped,
  showMovie,
}

class PeopleDetailPageActionCreator {
  static Action onAction() {
    return const Action(PeopleDetailPageAction.action);
  }

  static Action onInit(PeopleDetailModel p) {
    return Action(PeopleDetailPageAction.init, payload: p);
  }

  static Action onSetCreditModel(
      CombinedCreditsModel p, List<CombinedCastData> cast) {
    return Action(PeopleDetailPageAction.setCreditModel, payload: [p, cast]);
  }

  static Action onShowBiography() {
    return Action(PeopleDetailPageAction.showBiography);
  }

  static Action onCellTapped(
      int id, String bgpic, String name, String poster, MediaType type) {
    return Action(PeopleDetailPageAction.cellTapped,
        payload: [id, bgpic, name, poster, type]);
  }

  static Action showMovie(bool d) {
    return Action(PeopleDetailPageAction.showMovie, payload: d);
  }
}
