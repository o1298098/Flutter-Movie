import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/models.dart';
import 'package:movie/views/stream_link/episode_livestream_page/components/bottom_panel_component/state.dart';
import 'package:movie/widgets/overlay_entry_manage.dart';

class StreamLinkFilterState implements Cloneable<StreamLinkFilterState> {
  List<TvShowStreamLink> streamLinks;
  List<TvShowStreamLink> filterLinks;
  TvShowStreamLink selectedLink;
  String selectHost;
  String selectLanguage;
  String selectQuality;
  String sort;
  bool sortAsc;
  GlobalKey<OverlayEntryManageState> overlayStateKey;
  StreamLinkFilterState({this.overlayStateKey});
  @override
  StreamLinkFilterState clone() {
    return StreamLinkFilterState()
      ..streamLinks = streamLinks
      ..filterLinks = filterLinks
      ..selectedLink = selectedLink
      ..overlayStateKey = overlayStateKey
      ..selectHost = selectHost
      ..selectLanguage = selectLanguage
      ..selectQuality = selectQuality
      ..sort = sort
      ..sortAsc = sortAsc;
  }
}

class StreamLinkFilterConnector
    extends ConnOp<BottomPanelState, StreamLinkFilterState> {
  @override
  StreamLinkFilterState get(BottomPanelState state) {
    StreamLinkFilterState mstate = StreamLinkFilterState();
    mstate.streamLinks = state.streamLinks?.list
        ?.where((e) => e.episode == state.selectEpisode)
        ?.toList();
    mstate.selectedLink = state.selectedLink;
    mstate.overlayStateKey = state.streamLinkFilterState.overlayStateKey;
    mstate.selectHost = state.streamLinkFilterState.selectHost;
    mstate.selectLanguage = state.streamLinkFilterState.selectLanguage;
    mstate.selectQuality = state.streamLinkFilterState.selectQuality;
    mstate.sort = state.streamLinkFilterState.sort;
    mstate.sortAsc = state.streamLinkFilterState.sortAsc;
    mstate.filterLinks = state.streamLinkFilterState.filterLinks ??
        state.streamLinks?.list
            ?.where((e) => e.episode == state.selectEpisode)
            ?.toList();
    return mstate;
  }

  @override
  void set(BottomPanelState state, StreamLinkFilterState subState) {
    state.selectedLink = subState.selectedLink;
    state.streamLinks.list = subState.streamLinks;
    state.streamLinkFilterState = subState;
  }
}
