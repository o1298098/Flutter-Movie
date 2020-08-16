import 'dart:convert' show json;

import 'package:movie/models/credits_model.dart';
import 'base_api_model/tvshow_stream_link.dart';
import 'image_model.dart';
import 'video_model.dart';

class Episode {
  int episodeNumber;
  int id;
  int seasonNumber;
  double voteAverage;
  int voteCount;
  String airDate;
  String name;
  String overview;
  String productionCode;
  String stillPath;
  List<CrewData> crew;
  List<CastData> guestStars;
  CreditsModel credits;
  EpisodeImageModel images;
  VideoModel videos;
  TvShowStreamLink streamLink;
  bool playState;
  Episode.fromParams(
      {this.episodeNumber,
      this.id,
      this.seasonNumber,
      this.voteAverage,
      this.voteCount,
      this.airDate,
      this.name,
      this.overview,
      this.productionCode,
      this.stillPath,
      this.crew,
      this.guestStars,
      this.credits,
      this.images,
      this.videos});

  factory Episode(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new Episode.fromJson(json.decode(jsonStr))
          : new Episode.fromJson(jsonStr);

  Episode.fromJson(jsonRes) {
    episodeNumber = jsonRes['episode_number'];
    id = jsonRes['id'];
    seasonNumber = jsonRes['season_number'];
    voteAverage = double.parse(jsonRes['vote_average'].toString());
    voteCount = jsonRes['vote_count'];
    airDate = jsonRes['air_date'];
    name = jsonRes['name'];
    overview = jsonRes['overview'];
    productionCode = jsonRes['production_code'];
    stillPath = jsonRes['still_path'];
    crew = jsonRes['crew'] == null ? null : [];
    guestStars = jsonRes['guest_stars'] == null ? null : [];

    for (var crewItem in crew == null ? [] : jsonRes['crew']) {
      crew.add(crewItem == null ? null : new CrewData.fromJson(crewItem));
    }

    guestStars = jsonRes['guest_stars'] == null ? null : [];

    for (var guest_starsItem
        in guestStars == null ? [] : jsonRes['guest_stars']) {
      guestStars.add(guest_starsItem == null
          ? null
          : new CastData.fromJson(guest_starsItem));
    }

    credits = jsonRes['credits'] == null
        ? null
        : new CreditsModel.fromJson(jsonRes['credits']);
    images = jsonRes['images'] == null
        ? null
        : new EpisodeImageModel.fromJson(jsonRes['images']);
    videos = jsonRes['videos'] == null
        ? null
        : new VideoModel.fromJson(jsonRes['videos']);
  }

  @override
  String toString() {
    return '{"episode_number": $episodeNumber,"id": $id,"season_number": $seasonNumber,"vote_average": $voteAverage,"vote_count": $voteCount,"air_date": ${airDate != null ? '${json.encode(airDate)}' : 'null'},"name": ${name != null ? '${json.encode(name)}' : 'null'},"overview": ${overview != null ? '${json.encode(overview)}' : 'null'},"production_code": ${productionCode != null ? '${json.encode(productionCode)}' : 'null'},"still_path": ${stillPath != null ? '${json.encode(stillPath)}' : 'null'},"crew": $crew,"guest_stars": $guestStars,"credits": $credits,"images": $images,"videos": $videos}';
  }
}

class EpisodeImageModel {
  List<ImageData> stills;

  EpisodeImageModel.fromParams({this.stills});

  EpisodeImageModel.fromJson(jsonRes) {
    stills = jsonRes['stills'] == null ? null : [];

    for (var stillsItem in stills == null ? [] : jsonRes['stills']) {
      stills
          .add(stillsItem == null ? null : new ImageData.fromJson(stillsItem));
    }
  }

  @override
  String toString() {
    return '{"stills": $stills}';
  }
}
