import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/enums/streamlink_type.dart';

import 'action.dart';
import 'state.dart';

Reducer<AddLinkPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<AddLinkPageState>>{
      AddLinkPageAction.action: _onAction,
      AddLinkPageAction.setLinkName: _setLinkName,
      AddLinkPageAction.setStreamLink: _setStreamLink,
      AddLinkPageAction.setLinkData: _setLinkData,
      AddLinkPageAction.streamLinkTypeChanged: _streamLinkTypeChanged,
    },
  );
}

AddLinkPageState _onAction(AddLinkPageState state, Action action) {
  final AddLinkPageState newState = state.clone();
  return newState;
}

AddLinkPageState _streamLinkTypeChanged(AddLinkPageState state, Action action) {
  final StreamLinkType type = action.payload ?? StreamLinkType.other;
  final AddLinkPageState newState = state.clone();
  newState.streamLinkType = type;
  return newState;
}

AddLinkPageState _setLinkName(AddLinkPageState state, Action action) {
  final String t = action.payload ?? '';
  final AddLinkPageState newState = state.clone();
  newState.linkName = t;
  return newState;
}

AddLinkPageState _setStreamLink(AddLinkPageState state, Action action) {
  final String t = action.payload ?? '';
  final AddLinkPageState newState = state.clone();
  newState.streamLink = t;
  return newState;
}

AddLinkPageState _setLinkData(AddLinkPageState state, Action action) {
  final DocumentSnapshot d = action.payload;
  final AddLinkPageState newState = state.clone();
  newState.linkData = d;
  newState.linkName = d['linkName'];
  newState.streamLink = d['streamLink'];
  newState.streamLinkType = d['streamLinkType'] == 'YouTube'
      ? StreamLinkType.youtube
      : StreamLinkType.other;
  return newState;
}
