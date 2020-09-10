import 'dart:convert' show json;

class ReleaseDateModel {

  int id;
  List<ReleaseDateResult> results;

  ReleaseDateModel.fromParams({this.id, this.results});

  factory ReleaseDateModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? new ReleaseDateModel.fromJson(json.decode(jsonStr)) : new ReleaseDateModel.fromJson(jsonStr);
  
  ReleaseDateModel.fromJson(jsonRes) {
    id = jsonRes['id'];
    results = jsonRes['results'] == null ? null : [];

    for (var resultsItem in results == null ? [] : jsonRes['results']){
            results.add(resultsItem == null ? null : new ReleaseDateResult.fromJson(resultsItem));
    }
  }

  @override
  String toString() {
    return '{"id": $id,"results": $results}';
  }
}

class ReleaseDateResult {

  String iso31661;
  List<ReleaseDateInfo> releaseDates;

  ReleaseDateResult.fromParams({this.iso31661, this.releaseDates});
  
  ReleaseDateResult.fromJson(jsonRes) {
    iso31661 = jsonRes['iso_3166_1'];
    releaseDates = jsonRes['release_dates'] == null ? null : [];

    for (var releaseDatesItem in releaseDates == null ? [] : jsonRes['release_dates']){
            releaseDates.add(releaseDatesItem == null ? null : new ReleaseDateInfo.fromJson(releaseDatesItem));
    }
  }

  @override
  String toString() {
    return '{"iso_3166_1": ${iso31661 != null?'${json.encode(iso31661)}':'null'},"release_dates": $releaseDates}';
  }
}

class ReleaseDateInfo {

  int type;
  String certification;
  String iso6391;
  String note;
  String releaseDate;

  ReleaseDateInfo.fromParams({this.type, this.certification, this.iso6391, this.note, this.releaseDate});
  
  ReleaseDateInfo.fromJson(jsonRes) {
    type = jsonRes['type'];
    certification = jsonRes['certification'];
    iso6391 = jsonRes['iso_639_1'];
    note = jsonRes['note'];
    releaseDate = jsonRes['release_date'];
  }

  @override
  String toString() {
    return '{"type": $type,"certification": ${certification != null?'${json.encode(certification)}':'null'},"iso_639_1": ${iso6391 != null?'${json.encode(iso6391)}':'null'},"note": ${note != null?'${json.encode(note)}':'null'},"release_date": ${releaseDate != null?'${json.encode(releaseDate)}':'null'}}';
  }
}

