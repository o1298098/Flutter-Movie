import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:movie/globalbasestate/state.dart';
import 'package:movie/models/app_user.dart';

class TestPageState implements GlobalBaseState, Cloneable<TestPageState> {
  Stream<QuerySnapshot> testData;

  @override
  TestPageState clone() {
    return TestPageState()
      ..testData = testData
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
