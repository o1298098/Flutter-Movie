import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/video_list.dart';
import 'package:movie/views/tvshow_detail_page/state.dart';

class RecommendationState implements Cloneable<RecommendationState> {
  List<VideoListResult> data;
  @override
  RecommendationState clone() {
    return RecommendationState()..data = data;
  }
}

class RecommendationConnector
    extends ConnOp<TvShowDetailState, RecommendationState> {
  @override
  RecommendationState get(TvShowDetailState state) {
    RecommendationState substate = new RecommendationState();
    substate.data = state.tvDetailModel?.recommendations?.results;
    return substate;
  }
}
