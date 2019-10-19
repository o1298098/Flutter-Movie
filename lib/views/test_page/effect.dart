import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<TestPageState> buildEffect() {
  return combineEffects(<Object, Effect<TestPageState>>{
    TestPageAction.action: _onAction,
    Lifecycle.initState: _onInit,
  });
}

void _onAction(Action action, Context<TestPageState> ctx) {}
void _onInit(Action action, Context<TestPageState> ctx) {
  final s = Firestore.instance.collection("SteamLinks").snapshots();
  ctx.dispatch(TestPageActionCreator.setData(s));
}
