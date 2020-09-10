import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/models.dart';

import 'action.dart';
import 'state.dart';

Reducer<StreamLinkFilterState> buildReducer() {
  return asReducer(
    <Object, Reducer<StreamLinkFilterState>>{
      StreamLinkFilterAction.action: _onAction,
      StreamLinkFilterAction.setSelectedLink: _setSelectedLink,
      StreamLinkFilterAction.setHost: _setHost,
      StreamLinkFilterAction.setLanguage: _setLanguage,
      StreamLinkFilterAction.setQuality: _setQuality,
      StreamLinkFilterAction.setFilterList: _setFilterList,
      StreamLinkFilterAction.setSort: _setSort,
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

StreamLinkFilterState _setHost(StreamLinkFilterState state, Action action) {
  final String _host = action.payload;
  final StreamLinkFilterState newState = state.clone();
  newState.selectHost = _host;
  return newState;
}

StreamLinkFilterState _setLanguage(StreamLinkFilterState state, Action action) {
  final String _language = action.payload;
  final StreamLinkFilterState newState = state.clone();
  newState.selectLanguage = _language;
  return newState;
}

StreamLinkFilterState _setQuality(StreamLinkFilterState state, Action action) {
  final String _quality = action.payload;
  final StreamLinkFilterState newState = state.clone();
  newState.selectQuality = _quality;
  return newState;
}

StreamLinkFilterState _setFilterList(
    StreamLinkFilterState state, Action action) {
  final List<MovieStreamLink> _list = action.payload;
  final StreamLinkFilterState newState = state.clone();
  newState.filterLinks = _list;
  return newState;
}

StreamLinkFilterState _setSort(StreamLinkFilterState state, Action action) {
  final String _sort = action.payload[0];
  final bool _asc = action.payload[1];
  final StreamLinkFilterState newState = state.clone();
  newState.sort = _sort;
  newState.sortAsc = _asc;
  return newState;
}
