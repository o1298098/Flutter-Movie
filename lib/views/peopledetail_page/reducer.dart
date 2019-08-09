import 'package:fish_redux/fish_redux.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/models/combinedcredits.dart';
import 'package:movie/models/peopledetail.dart';

import 'action.dart';
import 'state.dart';

Reducer<PeopleDetailPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<PeopleDetailPageState>>{
      PeopleDetailPageAction.action: _onAction,
      PeopleDetailPageAction.init: _onInit,
      PeopleDetailPageAction.setCreditModel: _onSetCreditModel,
      PeopleDetailPageAction.showBiography: _onShowBiography
    },
  );
}

PeopleDetailPageState _onAction(PeopleDetailPageState state, Action action) {
  final PeopleDetailPageState newState = state.clone();
  return newState;
}

PeopleDetailPageState _onInit(PeopleDetailPageState state, Action action) {
  final PeopleDetailModel m = action.payload ??
      PeopleDetailModel.fromParams(also_known_as: List<String>());
  final PeopleDetailPageState newState = state.clone();
  newState.peopleDetailModel = m;
  double s = (m.biography.length *
          Adapt.px(30) /
          (Adapt.screenW() / Adapt.onepx() - Adapt.px(60)))
      .floorToDouble();
  newState.biographyHeight = s * Adapt.px(30);
  return newState;
}

PeopleDetailPageState _onSetCreditModel(
    PeopleDetailPageState state, Action action) {
  final CombinedCreditsModel m =
      action.payload[0] ?? CombinedCreditsModel.fromParams(cast: [], crew: []);
  final List<CastData> cast = action.payload[1] ?? [];
  final PeopleDetailPageState newState = state.clone();
  newState.creditsModel = m;
  newState.knowForCast = cast;
  return newState;
}

PeopleDetailPageState _onShowBiography(
    PeopleDetailPageState state, Action action) {
  final PeopleDetailPageState newState = state.clone();
  if (state.isBiographyOpen) {
    newState.biographyHeight = Adapt.px(200);
    newState.isBiographyOpen = false;
  } else {
    newState.biographyHeight = Adapt.px(500);
    newState.isBiographyOpen = true;
  }
  return newState;
}
