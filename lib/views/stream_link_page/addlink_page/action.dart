import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/enums/streamlink_type.dart';

enum AddLinkPageAction {
  action,
  submit,
  setLinkName,
  setStreamLink,
  setLinkData,
  streamLinkTypeChanged,
}

class AddLinkPageActionCreator {
  static Action onAction() {
    return const Action(AddLinkPageAction.action);
  }

  static Action streamLinkTypeChanged(StreamLinkType type) {
    return Action(AddLinkPageAction.streamLinkTypeChanged, payload: type);
  }

  static Action submit() {
    return const Action(AddLinkPageAction.submit);
  }

  static Action setLinkName(String s) {
    return Action(AddLinkPageAction.setLinkName, payload: s);
  }

  static Action setStreamLink(String s) {
    return Action(AddLinkPageAction.setStreamLink, payload: s);
  }

  static Action setLinkData(DocumentSnapshot linkData) {
    return Action(AddLinkPageAction.setLinkData, payload: linkData);
  }
}
