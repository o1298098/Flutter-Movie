import 'dart:convert' show json;

class BaseTvShowModel {
  int page;
  List<BaseTvShow> data;

  BaseTvShowModel.fromParams({this.page, this.data});

  factory BaseTvShowModel(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new BaseTvShowModel.fromJson(json.decode(jsonStr))
          : new BaseTvShowModel.fromJson(jsonStr);

  BaseTvShowModel.fromJson(jsonRes) {
    page = jsonRes['page'];
    data = jsonRes['data'] == null ? null : [];

    for (var dataItem in data == null ? [] : jsonRes['data']) {
      data.add(dataItem == null ? null : new BaseTvShow.fromJson(dataItem));
    }
  }

  @override
  String toString() {
    return '{"page": $page,"data": $data}';
  }
}

class BaseTvShow {
  int id;
  int rateCount;
  int seasonCount;
  double popular;
  double rate;
  String firstAirDate;
  String genre;
  String name;
  String overwatch;
  String photourl;
  String updateTime;

  BaseTvShow.fromParams(
      {this.id,
      this.rateCount,
      this.seasonCount,
      this.popular,
      this.rate,
      this.firstAirDate,
      this.genre,
      this.name,
      this.overwatch,
      this.photourl,
      this.updateTime});

  BaseTvShow.fromJson(jsonRes) {
    id = jsonRes['id'];
    rateCount = jsonRes['rateCount'];
    seasonCount = jsonRes['seasonCount'];
    popular = jsonRes['popular'];
    rate = double.parse(jsonRes['rate']?.toString() ?? '0.0');
    firstAirDate = jsonRes['firstAirDate'];
    genre = jsonRes['genre'];
    name = jsonRes['name'];
    overwatch = jsonRes['overwatch'];
    photourl = jsonRes['photourl'];
    updateTime = jsonRes['updateTime'];
  }

  @override
  String toString() {
    return '{"id": $id,"rateCount": $rateCount,"seasonCount": $seasonCount,"popular": $popular,"rate": $rate,"firstAirDate": ${firstAirDate != null ? '${json.encode(firstAirDate)}' : 'null'},"genre": ${genre != null ? '${json.encode(genre)}' : 'null'},"name": ${name != null ? '${json.encode(name)}' : 'null'},"overwatch": ${overwatch != null ? '${json.encode(overwatch)}' : 'null'},"photourl": ${photourl != null ? '${json.encode(photourl)}' : 'null'},"updateTime": ${updateTime != null ? '${json.encode(updateTime)}' : 'null'}}';
  }
}
