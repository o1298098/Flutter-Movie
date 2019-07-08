import 'dart:convert' show json;

import 'creditsmodel.dart';

class SeasonDetailModel {

  int id;
  int season_number;
  String uid;
  String air_date;
  String name;
  String overview;
  String poster_path;
  List<Episode> episodes;
  CreditsModel credits;

  SeasonDetailModel.fromParams({this.id, this.season_number, this.uid, this.air_date, this.name, this.overview, this.poster_path, this.episodes, this.credits});

  factory SeasonDetailModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? new SeasonDetailModel.fromJson(json.decode(jsonStr)) : new SeasonDetailModel.fromJson(jsonStr);
  
  SeasonDetailModel.fromJson(jsonRes) {
    id = jsonRes['id'];
    season_number = jsonRes['season_number'];
    uid = jsonRes['_id'];
    air_date = jsonRes['air_date'];
    name = jsonRes['name'];
    overview = jsonRes['overview'];
    poster_path = jsonRes['poster_path'];
    episodes = jsonRes['episodes'] == null ? null : [];

    for (var episodesItem in episodes == null ? [] : jsonRes['episodes']){
            episodes.add(episodesItem == null ? null : new Episode.fromJson(episodesItem));
    }

    credits = jsonRes['credits'] == null ? null : new CreditsModel.fromJson(jsonRes['credits']);
  }

  @override
  String toString() {
    return '{"id": $id,"season_number": $season_number,"_id": ${uid != null?'${json.encode(uid)}':'null'},"air_date": ${air_date != null?'${json.encode(air_date)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'},"overview": ${overview != null?'${json.encode(overview)}':'null'},"poster_path": ${poster_path != null?'${json.encode(poster_path)}':'null'},"episodes": $episodes,"credits": $credits}';
  }
}

class Episode {

  int episode_number;
  int id;
  int season_number;
  int show_id;
  int vote_count;
  double vote_average;
  String air_date;
  String name;
  String overview;
  String production_code;
  String still_path;
  List<dynamic> crew;
  List<CastData> guest_stars;
  bool expansionPanelOpened;

  Episode.fromParams({this.episode_number, this.id, this.season_number, this.show_id, this.vote_count, this.vote_average, this.air_date, this.name, this.overview, this.production_code, this.still_path, this.crew, this.guest_stars});
  
  Episode.fromJson(jsonRes) {
    episode_number = jsonRes['episode_number'];
    id = jsonRes['id'];
    season_number = jsonRes['season_number'];
    show_id = jsonRes['show_id'];
    vote_count = jsonRes['vote_count'];
    vote_average = jsonRes['vote_average'];
    air_date = jsonRes['air_date'];
    name = jsonRes['name'];
    overview = jsonRes['overview'];
    production_code = jsonRes['production_code'];
    still_path = jsonRes['still_path'];
    crew = jsonRes['crew'] == null ? null : [];

    for (var crewItem in crew == null ? [] : jsonRes['crew']){
            crew.add(crewItem);
    }

    guest_stars = jsonRes['guest_stars'] == null ? null : [];

    for (var guest_starsItem in guest_stars == null ? [] : jsonRes['guest_stars']){
            guest_stars.add(guest_starsItem == null ? null : new CastData.fromJson(guest_starsItem));
    }
  }

  @override
  String toString() {
    return '{"episode_number": $episode_number,"id": $id,"season_number": $season_number,"show_id": $show_id,"vote_count": $vote_count,"vote_average": $vote_average,"air_date": ${air_date != null?'${json.encode(air_date)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'},"overview": ${overview != null?'${json.encode(overview)}':'null'},"production_code": ${production_code != null?'${json.encode(production_code)}':'null'},"still_path": ${still_path != null?'${json.encode(still_path)}':'null'},"crew": $crew,"guest_stars": $guest_stars}';
  }
}

