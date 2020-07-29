import 'package:fish_redux/fish_redux.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'action.dart';
import 'state.dart';

Reducer<TestPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<TestPageState>>{
      TestPageAction.action: _onAction,
      TestPageAction.setData: _setData,
      TestPageAction.setData2: _setData2
    },
  );
}

TestPageState _onAction(TestPageState state, Action action) {
  final TestPageState newState = state.clone();
  return newState;
}

TestPageState _setData(TestPageState state, Action action) {
  final Stream<FetchResult> d = action.payload;
  final TestPageState newState = state.clone();
  newState.testData = d;
  return newState;
}

TestPageState _setData2(TestPageState state, Action action) {
  final Stream<FetchResult> d = action.payload;
  final TestPageState newState = state.clone();
  newState.testData2 = d;
  return newState;
}
