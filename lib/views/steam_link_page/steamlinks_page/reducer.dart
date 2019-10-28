import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<StreamLinksPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<StreamLinksPageState>>{
      StreamLinksPageAction.action: _onAction,
      StreamLinksPageAction.setSnapshot: _setSnapshot,
    },
  );
}

StreamLinksPageState _onAction(StreamLinksPageState state, Action action) {
  final StreamLinksPageState newState = state.clone();
  return newState;
}

StreamLinksPageState _setSnapshot(StreamLinksPageState state, Action action) {
  final Stream<QuerySnapshot> _snapshot = action.payload;
  final StreamLinksPageState newState = state.clone();
  newState.snapshot = _snapshot;
  return newState;
}
