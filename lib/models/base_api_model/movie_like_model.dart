import 'dart:convert' show json;

class MovieLikeModel {
  int id;
  int movieId;
  String uid;

  MovieLikeModel.fromParams({this.id, this.movieId, this.uid});

  factory MovieLikeModel(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new MovieLikeModel.fromJson(json.decode(jsonStr))
          : new MovieLikeModel.fromJson(jsonStr);

  MovieLikeModel.fromJson(jsonRes) {
    id = jsonRes['id'];
    movieId = jsonRes['movieId'];
    uid = jsonRes['uid'];
  }

  @override
  String toString() {
    return '{"id": $id"movieId": $movieId,"uid": ${uid != null ? '${json.encode(uid)}' : 'null'}}';
  }
}
