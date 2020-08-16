import 'dart:convert' show json;

import 'combined_cast_data.dart';
import 'combined_crew_data.dart';

class CombinedCreditsModel {
  int id;
  List<CombinedCastData> cast;
  List<CombinedCrewData> crew;

  CombinedCreditsModel.fromParams({this.id, this.cast, this.crew});

  factory CombinedCreditsModel(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new CombinedCreditsModel.fromJson(json.decode(jsonStr))
          : new CombinedCreditsModel.fromJson(jsonStr);

  CombinedCreditsModel.fromJson(jsonRes) {
    id = jsonRes['id'];
    cast = jsonRes['cast'] == null ? null : [];

    for (var castItem in cast == null ? [] : jsonRes['cast']) {
      cast.add(
          castItem == null ? null : new CombinedCastData.fromJson(castItem));
    }

    crew = jsonRes['crew'] == null ? null : [];

    for (var crewItem in crew == null ? [] : jsonRes['crew']) {
      crew.add(
          crewItem == null ? null : new CombinedCrewData.fromJson(crewItem));
    }
  }

  CombinedCreditsModel clone() {
    return new CombinedCreditsModel.fromParams(id: id, cast: cast, crew: crew);
  }

  @override
  String toString() {
    return '{"id": $id,"cast": $cast,"crew": $crew}';
  }
}
