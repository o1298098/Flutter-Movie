import 'package:fish_redux/fish_redux.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/models/models.dart';
import 'package:movie/models/people_detail.dart';

import 'action.dart';
import 'state.dart';

Reducer<PeopleDetailPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<PeopleDetailPageState>>{
      PeopleDetailPageAction.action: _onAction,
      PeopleDetailPageAction.init: _onInit,
      PeopleDetailPageAction.setCreditModel: _onSetCreditModel,
      PeopleDetailPageAction.showBiography: _onShowBiography,
      PeopleDetailPageAction.showMovie: _showMovie,
    },
  );
}

PeopleDetailPageState _onAction(PeopleDetailPageState state, Action action) {
  final PeopleDetailPageState newState = state.clone();
  return newState;
}

PeopleDetailPageState _onInit(PeopleDetailPageState state, Action action) {
  final PeopleDetailModel m = action.payload ??
      PeopleDetailModel.fromParams(alsoKnownAs:[]);
  final PeopleDetailPageState newState = state.clone();
  newState.peopleDetailModel = m;
  newState.profilePath = m.profilePath;
  return newState;
}

PeopleDetailPageState _onSetCreditModel(
    PeopleDetailPageState state, Action action) {
  final CombinedCreditsModel m =
      action.payload[0] ?? CombinedCreditsModel.fromParams(cast: [], crew: []);
  final List<CombinedCastData> cast = action.payload[1] ?? [];
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

PeopleDetailPageState _showMovie(PeopleDetailPageState state, Action action) {
  final b = action.payload ?? true;
  final PeopleDetailPageState newState = state.clone();
  newState.showmovie = b;
  return newState;
}
