import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:movie/globalbasestate/state.dart';
import 'package:movie/models/app_user.dart';

class TestPageState implements GlobalBaseState, Cloneable<TestPageState> {
  Stream<FetchResult> testData;
  Stream<FetchResult> testData2;
  @override
  TestPageState clone() {
    return TestPageState()
      ..testData = testData
      ..testData2 = testData2
      ..themeColor = themeColor
      ..locale = locale
      ..user = user;
  }

  @override
  Locale locale;

  @override
  Color themeColor;

  @override
  AppUser user;
}

TestPageState initState(Map<String, dynamic> args) {
  return TestPageState();
}
