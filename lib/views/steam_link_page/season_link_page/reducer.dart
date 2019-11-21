import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/tvdetail.dart';

import 'action.dart';
import 'state.dart';

Reducer<SeasonLinkPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<SeasonLinkPageState>>{
      SeasonLinkPageAction.action: _onAction,
      SeasonLinkPageAction.updateSeason: _updateSeason,
    },
  );
}

SeasonLinkPageState _onAction(SeasonLinkPageState state, Action action) {
  final SeasonLinkPageState newState = state.clone();
  return newState;
}

SeasonLinkPageState _updateSeason(SeasonLinkPageState state, Action action) {
  final TVDetailModel detail = action.payload;
  final SeasonLinkPageState newState = state.clone();
  newState.detial = detail;
  return newState;
}
