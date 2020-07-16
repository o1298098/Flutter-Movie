import 'package:fish_redux/fish_redux.dart';

enum BottomPanelAction {
  action,
  useVideoSource,
  setUseVideoSource,
  streamInBrowser,
  setStreamInBrowser,
}

class BottomPanelActionCreator {
  static Action onAction() {
    return const Action(BottomPanelAction.action);
  }

  static Action useVideoSource(bool useVideoSourceApi) {
    return Action(BottomPanelAction.useVideoSource, payload: useVideoSourceApi);
  }

  static Action setUseVideoSource(bool useVideoSource) {
    return Action(BottomPanelAction.setUseVideoSource, payload: useVideoSource);
  }

  static Action streamInBrowser(bool streamInBrowser) {
    return Action(BottomPanelAction.streamInBrowser, payload: streamInBrowser);
  }

  static Action setStreamInBrowser(bool streamInBrowser) {
    return Action(BottomPanelAction.setStreamInBrowser,
        payload: streamInBrowser);
  }
}
