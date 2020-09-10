import 'dart:convert' show json;

class UserMediaModel {
  int page;
  List<UserMedia> data;

  UserMediaModel.fromParams({this.page, this.data});

  factory UserMediaModel(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new UserMediaModel.fromJson(json.decode(jsonStr))
          : new UserMediaModel.fromJson(jsonStr);

  UserMediaModel.fromJson(jsonRes) {
    page = jsonRes['page'];
    data = jsonRes['data'] == null ? null : [];

    for (var dataItem in data == null ? [] : jsonRes['data']) {
      data.add(dataItem == null ? null : new UserMedia.fromJson(dataItem));
    }
  }

  @override
  String toString() {
    return '{"page": $page,"data": $data}';
  }
}

class UserMedia {
  int id;
  int mediaId;
  int ratedCount;
  double popular;
  double rated;
  String genre;
  String mediaType;
  String name;
  String overwatch;
  String photoUrl;
  String uid;
  String releaseDate;

  UserMedia.fromParams(
      {this.id,
      this.mediaId,
      this.ratedCount,
      this.popular,
      this.rated,
      this.genre,
      this.mediaType,
      this.name,
      this.overwatch,
      this.photoUrl,
      this.uid,
      this.releaseDate});

  UserMedia.fromJson(jsonRes) {
    id = jsonRes['id'];
    mediaId = jsonRes['mediaId'];
    ratedCount = jsonRes['ratedCount'];
    popular = jsonRes['popular'];
    rated = jsonRes['rated'];
    genre = jsonRes['genre'];
    mediaType = jsonRes['mediaType'];
    name = jsonRes['name'];
    overwatch = jsonRes['overwatch'];
    photoUrl = jsonRes['photoUrl'];
    uid = jsonRes['uid'];
    releaseDate = jsonRes['releaseDate'];
  }

  @override
  String toString() {
    return '{"id": $id,"mediaId": $mediaId,"ratedCount": $ratedCount,"popular": $popular,"rated": $rated,"genre": ${genre != null ? '${json.encode(genre)}' : 'null'},"mediaType": ${mediaType != null ? '${json.encode(mediaType)}' : 'null'},"name": ${name != null ? '${json.encode(name)}' : 'null'},"overwatch": ${overwatch != null ? '${json.encode(overwatch)}' : 'null'},"photoUrl": ${photoUrl != null ? '${json.encode(photoUrl)}' : 'null'},"uid": ${uid != null ? '${json.encode(uid)}' : 'null'},"releaseDate": ${releaseDate != null ? '${json.encode(releaseDate)}' : 'null'}}';
  }
}
