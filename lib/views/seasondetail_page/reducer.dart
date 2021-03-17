import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/image_model.dart';
import 'package:movie/models/season_detail.dart';
import 'package:movie/models/video_model.dart';
import 'package:movie/views/seasondetail_page/components/seasoncast_component/state.dart';

import 'action.dart';
import 'state.dart';

Reducer<SeasonDetailPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<SeasonDetailPageState>>{
      SeasonDetailPageAction.action: _onAction,
      SeasonDetailPageAction.seasonDetailChanged: _onSeasonDetailChanged,
      SeasonDetailPageAction.setImages: _setImages,
      SeasonDetailPageAction.setVideos: _setVideos,
    },
  );
}

SeasonDetailPageState _onAction(SeasonDetailPageState state, Action action) {
  final SeasonDetailPageState newState = state.clone();
  return newState;
}

SeasonDetailPageState _onSeasonDetailChanged(
    SeasonDetailPageState state, Action action) {
  final Season model =
      action.payload ?? Season.fromParams(episodes: []);
  final SeasonDetailPageState newState = state.clone();
  newState.seasonDetailModel = model;
  newState.seasonCastState = new SeasonCastState(castData: model.credits.cast);
  return newState;
}

SeasonDetailPageState _setVideos(SeasonDetailPageState state, Action action) {
  final VideoModel _videos = action.payload;
  final SeasonDetailPageState newState = state.clone();
  newState.videos = _videos;
  return newState;
}

SeasonDetailPageState _setImages(SeasonDetailPageState state, Action action) {
  final ImageModel _images = action.payload;
  final SeasonDetailPageState newState = state.clone();
  newState.images = _images;
  return newState;
}
