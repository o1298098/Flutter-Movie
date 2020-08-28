import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/models.dart';

enum StreamLinkFilterAction {
  action,
  selectedLinkTap,
  setSelectedLink,
}

class StreamLinkFilterActionCreator {
  static Action onAction() {
    return const Action(StreamLinkFilterAction.action);
  }

  static Action streamlinkTap(MovieStreamLink link) {
    return Action(StreamLinkFilterAction.selectedLinkTap, payload: link);
  }

  static Action setSelectedLink(MovieStreamLink link) {
    return Action(StreamLinkFilterAction.setSelectedLink, payload: link);
  }
}
