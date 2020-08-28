import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/models.dart';

import 'action.dart';
import 'state.dart';

Reducer<StreamLinkFilterState> buildReducer() {
  return asReducer(
    <Object, Reducer<StreamLinkFilterState>>{
      StreamLinkFilterAction.action: _onAction,
      StreamLinkFilterAction.setSelectedLink: _setSelectedLink,
    },
  );
}

StreamLinkFilterState _onAction(StreamLinkFilterState state, Action action) {
  final StreamLinkFilterState newState = state.clone();
  return newState;
}

StreamLinkFilterState _setSelectedLink(
    StreamLinkFilterState state, Action action) {
  final MovieStreamLink _link = action.payload;
  final StreamLinkFilterState newState = state.clone();
  newState.streamLinks.list.remove(_link);
  newState.streamLinks.list.insert(0, _link);
  newState.selectedLink = _link;
  return newState;
}
