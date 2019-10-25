import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum TestPageAction { action, setData, googleSignIn, inputTapped }

class TestPageActionCreator {
  static Action onAction() {
    return const Action(TestPageAction.action);
  }

  static Action setData(Stream<QuerySnapshot> d) {
    return Action(TestPageAction.setData, payload: d);
  }

  static Action googleSignIn() {
    return const Action(TestPageAction.googleSignIn);
  }

  static Action inputTapped() {
    return const Action(TestPageAction.inputTapped);
  }
}
