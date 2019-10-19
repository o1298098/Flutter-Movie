import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fish_redux/fish_redux.dart';

class TestPageState implements Cloneable<TestPageState> {
  Stream<QuerySnapshot> testData;

  @override
  TestPageState clone() {
    return TestPageState()..testData = testData;
  }
}

TestPageState initState(Map<String, dynamic> args) {
  return TestPageState();
}
