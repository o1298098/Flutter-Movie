import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum StreamLinksPageAction { action, setSnapshot }

class StreamLinksPageActionCreator {
  static Action onAction() {
    return const Action(StreamLinksPageAction.action);
  }

  static Action setSnapshot(Stream<QuerySnapshot> s) {
    return Action(StreamLinksPageAction.setSnapshot, payload: s);
  }
}
