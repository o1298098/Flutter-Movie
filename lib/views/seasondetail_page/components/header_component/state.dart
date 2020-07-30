import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/image_model.dart';
import 'package:movie/models/video_model.dart';
import 'package:movie/views/seasondetail_page/state.dart';

class HeaderState implements Cloneable<HeaderState> {
  String posterurl;
  String name;
  String seasonName;
  String overwatch;
  String airDate;
  int seasonNumber;
  VideoModel videos;
  ImageModel images;

  HeaderState(
      {this.name,
      this.overwatch,
      this.posterurl,
      this.airDate,
      this.seasonNumber,
      this.seasonName,
      this.images,
      this.videos});

  @override
  HeaderState clone() {
    return HeaderState()
      ..posterurl = posterurl
      ..name = name
      ..overwatch
      ..seasonName = seasonName
      ..seasonNumber = seasonNumber
      ..videos = videos
      ..images = images;
  }
}

class HeaderConnector extends ConnOp<SeasonDetailPageState, HeaderState> {
  @override
  HeaderState get(SeasonDetailPageState state) {
    HeaderState mstate = HeaderState();
    mstate.posterurl = state.seasonDetailModel?.posterPath;
    mstate.overwatch = state.seasonDetailModel?.overview;
    mstate.name = state.tvShowName;
    mstate.airDate = state.seasonDetailModel?.airDate;
    mstate.seasonName = state.name ?? '';
    mstate.seasonNumber = state.seasonNumber;
    mstate.images = state.images;
    mstate.videos = state.videos;
    return mstate;
  }
}
