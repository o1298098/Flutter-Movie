import 'dart:convert' show json;

import 'credits_model.dart';
import 'episode_model.dart';

class Season {
  int id;
  int seasonNumber;
  int episodeCount;
  String uid;
  String airDate;
  String name;
  String overview;
  String posterPath;
  List<Episode> episodes;
  List<String> playStates;
  CreditsModel credits;

  Season.fromParams(
      {this.id,
      this.episodeCount,
      this.seasonNumber,
      this.uid,
      this.airDate,
      this.name,
      this.overview,
      this.posterPath,
      this.episodes,
      this.credits});

  factory Season(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new Season.fromJson(json.decode(jsonStr))
          : new Season.fromJson(jsonStr);

  Season.fromJson(jsonRes) {
    id = jsonRes['id'];
    episodeCount = jsonRes['episode_count'];
    seasonNumber = jsonRes['season_number'];
    uid = jsonRes['_id'];
    airDate = jsonRes['air_date'];
    name = jsonRes['name'];
    overview = jsonRes['overview'];
    posterPath = jsonRes['poster_path'];
    episodes = jsonRes['episodes'] == null ? null : [];

    for (var episodesItem in episodes == null ? [] : jsonRes['episodes']) {
      episodes.add(
          episodesItem == null ? null : new Episode.fromJson(episodesItem));
    }

    credits = jsonRes['credits'] == null
        ? null
        : new CreditsModel.fromJson(jsonRes['credits']);
  }

  @override
  String toString() {
    return '{"id": $id,"episode_count": $episodeCount,"season_number": $seasonNumber,"_id": ${uid != null ? '${json.encode(uid)}' : 'null'},"air_date": ${airDate != null ? '${json.encode(airDate)}' : 'null'},"name": ${name != null ? '${json.encode(name)}' : 'null'},"overview": ${overview != null ? '${json.encode(overview)}' : 'null'},"poster_path": ${posterPath != null ? '${json.encode(posterPath)}' : 'null'},"episodes": $episodes,"credits": $credits}';
  }
}
