import 'dart:convert' show json;

import 'creditsmodel.dart' ;
import 'episodemodel.dart';

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
