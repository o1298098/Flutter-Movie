import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/firebase/firebase_streamlink.dart';

//TODO replace with your own action
enum LiveStreamPageAction {
  action,
  setStreamLinks,
  chipSelected,
  commentChanged,
  addComment,
}

class LiveStreamPageActionCreator {
  static Action onAction() {
    return const Action(LiveStreamPageAction.action);
  }

  static Action setStreamLinks(List<StreamLinkModel> streamLinks) {
    return Action(LiveStreamPageAction.setStreamLinks, payload: streamLinks);
  }

  static Action chipSelected(StreamLinkModel d) {
    return Action(LiveStreamPageAction.chipSelected, payload: d);
  }

  static Action commentChanged(String comment) {
    return Action(LiveStreamPageAction.commentChanged, payload: comment);
  }

  static Action addComment(String comment) {
    return Action(LiveStreamPageAction.addComment, payload: comment);
  }
}
