import 'dart:convert' show json;

class BaseMovieModel {
  int page;
  List<BaseMovie> data;

  BaseMovieModel.fromParams({this.page, this.data});

  factory BaseMovieModel(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new BaseMovieModel.fromJson(json.decode(jsonStr))
          : new BaseMovieModel.fromJson(jsonStr);

  BaseMovieModel.fromJson(jsonRes) {
    page = jsonRes['page'];
    data = jsonRes['data'] == null ? null : [];

    for (var dataItem in data == null ? [] : jsonRes['data']) {
      data.add(dataItem == null ? null : new BaseMovie.fromJson(dataItem));
    }
  }

  @override
  String toString() {
    return '{"page": $page,"data": $data}';
  }
}

class BaseMovie {
  int id;
  int ratedCount;
  double popular;
  double rate;
  String genre;
  String name;
  String overwatch;
  String photourl;
  String releaseDate;
  String updateTime;

  BaseMovie.fromParams(
      {this.id,
      this.ratedCount,
      this.popular,
      this.rate,
      this.genre,
      this.name,
      this.overwatch,
      this.photourl,
      this.releaseDate,
      this.updateTime});

  BaseMovie.fromJson(jsonRes) {
    id = jsonRes['id'];
    ratedCount = jsonRes['ratedCount'];
    popular = jsonRes['popular'];
    rate = double.parse(jsonRes['rate']?.toString() ?? '0.0');
    genre = jsonRes['genre'];
    name = jsonRes['name'];
    overwatch = jsonRes['overwatch'];
    photourl = jsonRes['photourl'];
    releaseDate = jsonRes['releaseDate'];
    updateTime = jsonRes['updateTime'];
  }

  @override
  String toString() {
    return '{"id": $id,"ratedCount": $ratedCount,"popular": $popular,"rate": $rate,"genre": ${genre != null ? '${json.encode(genre)}' : 'null'},"name": ${name != null ? '${json.encode(name)}' : 'null'},"overwatch": ${overwatch != null ? '${json.encode(overwatch)}' : 'null'},"photourl": ${photourl != null ? '${json.encode(photourl)}' : 'null'},"releaseDate": ${releaseDate != null ? '${json.encode(releaseDate)}' : 'null'},"updateTime": ${updateTime != null ? '${json.encode(updateTime)}' : 'null'}}';
  }
}
