import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/tvshow_stream_link.dart';
import 'package:movie/models/episode_model.dart';
import 'package:movie/models/image_model.dart';
import 'package:movie/models/season_detail.dart';
import 'package:movie/models/video_model.dart';

enum SeasonDetailPageAction {
  action,
  seasonDetailChanged,
  setVideos,
  setImages,
  setStreamLinks,
  episodeCellTapped,
}

class SeasonDetailPageActionCreator {
  static Action onAction() {
    return const Action(SeasonDetailPageAction.action);
  }

  static Action onSeasonDetailChanged(Season s) {
    return Action(SeasonDetailPageAction.seasonDetailChanged, payload: s);
  }

  static Action setVideos(VideoModel videos) {
    return Action(SeasonDetailPageAction.setVideos, payload: videos);
  }

  static Action setImages(ImageModel images) {
    return Action(SeasonDetailPageAction.setImages, payload: images);
  }

  static Action setStreamLinks(TvShowStreamLinks streamLinks) {
    return Action(SeasonDetailPageAction.setStreamLinks, payload: streamLinks);
  }

  static Action episodeCellTapped(Episode p) {
    return Action(SeasonDetailPageAction.episodeCellTapped, payload: p);
  }
}
