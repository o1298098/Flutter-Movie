import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/models.dart';

enum StreamLinkFilterAction {
  action,
  selectedLinkTap,
  setSelectedLink,
  hostTap,
  languageTap,
  qualityTap,
  setHost,
  setLanguage,
  setQuality,
  setFilterList,
  sortTap,
  setSort,
}

class StreamLinkFilterActionCreator {
  static Action onAction() {
    return const Action(StreamLinkFilterAction.action);
  }

  static Action streamlinkTap(TvShowStreamLink link) {
    return Action(StreamLinkFilterAction.selectedLinkTap, payload: link);
  }

  static Action setSelectedLink(TvShowStreamLink link) {
    return Action(StreamLinkFilterAction.setSelectedLink, payload: link);
  }

  static Action hostTap(String host) {
    return Action(StreamLinkFilterAction.hostTap, payload: host);
  }

  static Action languageTap(String language) {
    return Action(StreamLinkFilterAction.languageTap, payload: language);
  }

  static Action qualityTap(String quality) {
    return Action(StreamLinkFilterAction.qualityTap, payload: quality);
  }

  static Action setHost(String host) {
    return Action(StreamLinkFilterAction.setHost, payload: host);
  }

  static Action setLanguage(String language) {
    return Action(StreamLinkFilterAction.setLanguage, payload: language);
  }

  static Action setQuality(String quality) {
    return Action(StreamLinkFilterAction.setQuality, payload: quality);
  }

  static Action setFilterList(List<TvShowStreamLink> list) {
    return Action(StreamLinkFilterAction.setFilterList, payload: list);
  }

  static Action sortTap(String sort, bool asc) {
    return Action(StreamLinkFilterAction.sortTap, payload: [sort, asc]);
  }

  static Action setSort(String sort, bool asc) {
    return Action(StreamLinkFilterAction.setSort, payload: [sort, asc]);
  }
}
