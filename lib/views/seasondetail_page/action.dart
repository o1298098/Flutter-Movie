import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/imagemodel.dart';
import 'package:movie/models/seasondetail.dart';
import 'package:movie/models/videomodel.dart';

enum SeasonDetailPageAction {
  action,
  seasonDetailChanged,
  setVideos,
  setImages
}

class SeasonDetailPageActionCreator {
  static Action onAction() {
    return const Action(SeasonDetailPageAction.action);
  }

  static Action onSeasonDetailChanged(SeasonDetailModel s) {
    return Action(SeasonDetailPageAction.seasonDetailChanged, payload: s);
  }

  static Action setVideos(VideoModel videos) {
    return Action(SeasonDetailPageAction.setVideos, payload: videos);
  }

  static Action setImages(ImageModel images) {
    return Action(SeasonDetailPageAction.setImages, payload: images);
  }
}
