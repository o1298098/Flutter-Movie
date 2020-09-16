import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/tvshow_stream_link.dart';

import 'action.dart';
import 'state.dart';

Reducer<BottomPanelState> buildReducer() {
  return asReducer(
    <Object, Reducer<BottomPanelState>>{
      BottomPanelAction.action: _onAction,
      BottomPanelAction.setUseVideoSource: _setUseVideoSource,
      BottomPanelAction.setStreamInBrowser: _setStreamInBrowser,
      BottomPanelAction.seletedLink: _selectedLink,
      BottomPanelAction.setOption: _setOption,
      BottomPanelAction.setLike: _setLike,
    },
  );
}

BottomPanelState _onAction(BottomPanelState state, Action action) {
  final BottomPanelState newState = state.clone();
  return newState;
}

BottomPanelState _setUseVideoSource(BottomPanelState state, Action action) {
  final bool _b = action.payload;
  final BottomPanelState newState = state.clone();
  newState.useVideoSourceApi = _b;
  return newState;
}

BottomPanelState _setStreamInBrowser(BottomPanelState state, Action action) {
  final bool _b = action.payload;
  final BottomPanelState newState = state.clone();
  newState.streamInBrowser = _b;
  return newState;
}

BottomPanelState _selectedLink(BottomPanelState state, Action action) {
  final TvShowStreamLink _link = action.payload;
  final BottomPanelState newState = state.clone();
  newState.selectedLink = _link;
  return newState;
}

BottomPanelState _setOption(BottomPanelState state, Action action) {
  final bool _api = action.payload[0];
  final bool _streamInBrowser = action.payload[1];
  final String _language = action.payload[2];
  final String _host = action.payload[3];
  final BottomPanelState newState = state.clone();
  newState.useVideoSourceApi = _api;
  newState.streamInBrowser = _streamInBrowser;
  newState.defaultVideoLanguage = _language;
  newState.preferHost = _host;
  return newState;
}

BottomPanelState _setLike(BottomPanelState state, Action action) {
  final int _count = action.payload[0] ?? 0;
  final bool _like = action.payload[1] ?? false;
  final BottomPanelState newState = state.clone();
  newState.likeCount = _count;
  newState.userLiked = _like;
  return newState;
}
