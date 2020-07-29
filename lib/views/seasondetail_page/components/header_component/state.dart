import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/image_model.dart';
import 'package:movie/models/video_model.dart';

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

HeaderState initState(Map<String, dynamic> args) {
  return HeaderState();
}
