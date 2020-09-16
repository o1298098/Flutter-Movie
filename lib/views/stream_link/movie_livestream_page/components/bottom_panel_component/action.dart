import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/movie_stream_link.dart';

enum BottomPanelAction {
  action,
  commentTap,
  useVideoSource,
  setUseVideoSource,
  streamInBrowser,
  setStreamInBrowser,
  seletedLink,
  setLike,
  likeMovie,
  setOption,
  reportStreamLink,
  requestStreamLink,
  showStreamlinkFilter,
  preferHostTap,
  setPreferHost,
  defaultLanguageTap,
  setDefaultLanguage,
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

  static Action seletedLink(MovieStreamLink link) {
    return Action(BottomPanelAction.seletedLink, payload: link);
  }

  static Action setLike(int likeCount, bool userLiked) {
    return Action(BottomPanelAction.setLike, payload: [likeCount, userLiked]);
  }

  static Action likeMovie() {
    return const Action(BottomPanelAction.likeMovie);
  }

  static Action commentTap() {
    return const Action(BottomPanelAction.commentTap);
  }

  static Action setOption(bool useVideoSourceApi, bool streamInBrowser,
      String language, String host) {
    return Action(BottomPanelAction.setOption,
        payload: [useVideoSourceApi, streamInBrowser, language, host]);
  }

  static Action reportStreamLink() {
    return const Action(BottomPanelAction.reportStreamLink);
  }

  static Action requestStreamLink() {
    return const Action(BottomPanelAction.requestStreamLink);
  }

  static Action showStreamLinkFilter() {
    return const Action(BottomPanelAction.showStreamlinkFilter);
  }

  static Action defaultLanguageTap(String code) {
    return Action(BottomPanelAction.defaultLanguageTap, payload: code);
  }

  static Action setDefaultLanguage(String code) {
    return Action(BottomPanelAction.setDefaultLanguage, payload: code);
  }

  static Action preferHostTap(String host) {
    return Action(BottomPanelAction.preferHostTap, payload: host);
  }

  static Action setPreferHost(String host) {
    return Action(BottomPanelAction.setPreferHost, payload: host);
  }
}
