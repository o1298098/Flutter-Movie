import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<TestPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<TestPageState>>{
      TestPageAction.action: _onAction,
      TestPageAction.setData: _setData
    },
  );
}

TestPageState _onAction(TestPageState state, Action action) {
  final TestPageState newState = state.clone();
  return newState;
}

TestPageState _setData(TestPageState state, Action action) {
  final Stream<QuerySnapshot> d = action.payload;
  final TestPageState newState = state.clone();
  newState.testData = d;
  return newState;
}
