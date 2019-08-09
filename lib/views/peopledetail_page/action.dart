import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/combinedcredits.dart';
import 'package:movie/models/peopledetail.dart';

//TODO replace with your own action
enum PeopleDetailPageAction { action, init, setCreditModel, showBiography }

class PeopleDetailPageActionCreator {
  static Action onAction() {
    return const Action(PeopleDetailPageAction.action);
  }

  static Action onInit(PeopleDetailModel p) {
    return Action(PeopleDetailPageAction.init, payload: p);
  }

  static Action onSetCreditModel(CombinedCreditsModel p, List<CastData> cast) {
    return Action(PeopleDetailPageAction.setCreditModel, payload: [p, cast]);
  }

  static Action onShowBiography() {
    return Action(PeopleDetailPageAction.showBiography);
  }
}
