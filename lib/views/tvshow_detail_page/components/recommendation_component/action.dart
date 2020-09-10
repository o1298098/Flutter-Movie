import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/video_list.dart';

enum RecommendationAction { action, cellTapped }

class RecommendationActionCreator {
  static Action onAction() {
    return const Action(RecommendationAction.action);
  }

  static Action cellTapped(VideoListResult data) {
    return Action(RecommendationAction.cellTapped, payload: data);
  }
}
