import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/movie_detail.dart';
import 'package:movie/models/video_list.dart';

enum RecommendationAction { action, cellTap, setDetail, setInfo }

class RecommendationActionCreator {
  static Action onAction() {
    return const Action(RecommendationAction.action);
  }

  static Action setInfo(VideoListResult data) {
    return Action(RecommendationAction.setInfo, payload: data);
  }

  static Action cellTap(VideoListResult data) {
    return Action(RecommendationAction.cellTap, payload: data);
  }

  static Action setDetail(MovieDetailModel detail) {
    return Action(RecommendationAction.setDetail, payload: detail);
  }
}
