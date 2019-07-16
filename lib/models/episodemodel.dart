import 'dart:convert' show json;

import 'package:movie/models/creditsmodel.dart';

import 'imagemodel.dart';
import 'videomodel.dart';

class Episode {

  int episode_number;
  int id;
  int season_number;
  double vote_average;
  int vote_count;
  String air_date;
  String name;
  String overview;
  String production_code;
  String still_path;
  List<CrewData> crew;
  List<CastData> guest_stars;
  CreditsModel credits;
  EpisodeImageModel images;
  VideoModel videos;

  Episode.fromParams({this.episode_number, this.id, this.season_number, this.vote_average, this.vote_count, this.air_date, this.name, this.overview, this.production_code, this.still_path, this.crew, this.guest_stars, this.credits, this.images, this.videos});

  factory Episode(jsonStr) => jsonStr == null ? null : jsonStr is String ? new Episode.fromJson(json.decode(jsonStr)) : new Episode.fromJson(jsonStr);
  
  Episode.fromJson(jsonRes) {
    episode_number = jsonRes['episode_number'];
    id = jsonRes['id'];
    season_number = jsonRes['season_number'];
    vote_average = double.parse(jsonRes['vote_average'].toString());
    vote_count = jsonRes['vote_count'];
    air_date = jsonRes['air_date'];
    name = jsonRes['name'];
    overview = jsonRes['overview'];
    production_code = jsonRes['production_code'];
    still_path = jsonRes['still_path'];
    crew = jsonRes['crew'] == null ? null : [];
    guest_stars = jsonRes['guest_stars'] == null ? null : [];

    for (var crewItem in crew == null ? [] : jsonRes['crew']){
            crew.add(crewItem == null ? null : new CrewData.fromJson(crewItem));
    }

    guest_stars = jsonRes['guest_stars'] == null ? null : [];

    for (var guest_starsItem in guest_stars == null ? [] : jsonRes['guest_stars']){
            guest_stars.add(guest_starsItem==null?null:new CastData.fromJson(guest_starsItem));
    }

    credits = jsonRes['credits'] == null ? null : new CreditsModel.fromJson(jsonRes['credits']);
    images = jsonRes['images'] == null ? null : new EpisodeImageModel.fromJson(jsonRes['images']);
    videos = jsonRes['videos'] == null ? null : new VideoModel.fromJson(jsonRes['videos']);
  }

  @override
  String toString() {
    return '{"episode_number": $episode_number,"id": $id,"season_number": $season_number,"vote_average": $vote_average,"vote_count": $vote_count,"air_date": ${air_date != null?'${json.encode(air_date)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'},"overview": ${overview != null?'${json.encode(overview)}':'null'},"production_code": ${production_code != null?'${json.encode(production_code)}':'null'},"still_path": ${still_path != null?'${json.encode(still_path)}':'null'},"crew": $crew,"guest_stars": $guest_stars,"credits": $credits,"images": $images,"videos": $videos}';
  }
}

class EpisodeImageModel {

  List<ImageData> stills;

  EpisodeImageModel.fromParams({this.stills});
  
  EpisodeImageModel.fromJson(jsonRes) {
    stills = jsonRes['stills'] == null ? null : [];

    for (var stillsItem in stills == null ? [] : jsonRes['stills']){
            stills.add(stillsItem == null ? null : new ImageData.fromJson(stillsItem));
    }
  }

  @override
  String toString() {
    return '{"stills": $stills}';
  }
}
