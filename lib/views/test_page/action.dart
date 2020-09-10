import 'package:fish_redux/fish_redux.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

enum TestPageAction { action, setData, setData2 }

class TestPageActionCreator {
  static Action onAction() {
    return const Action(TestPageAction.action);
  }

  static Action setData(Stream<FetchResult> d) {
    return Action(TestPageAction.setData, payload: d);
  }

  static Action setData2(Stream<FetchResult> d) {
    return Action(TestPageAction.setData2, payload: d);
  }
}
