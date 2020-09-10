import 'dart:convert' show json;

class AccountState {
  bool favorite;
  int id;
  int mediaId;
  bool watchlist;
  double rated;
  String mediaType;
  String uid;

  AccountState.fromParams(
      {this.favorite,
      this.id,
      this.mediaId,
      this.watchlist,
      this.rated,
      this.mediaType,
      this.uid});

  factory AccountState(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new AccountState.fromJson(json.decode(jsonStr))
          : new AccountState.fromJson(jsonStr);

  AccountState.fromJson(jsonRes) {
    favorite = jsonRes['favorite'] == 1 ? true : false;
    id = jsonRes['id'];
    mediaId = jsonRes['mediaId'];
    watchlist = jsonRes['watchlist'] == 1 ? true : false;
    rated = jsonRes['rated'];
    mediaType = jsonRes['mediaType'];
    uid = jsonRes['uid'];
  }

  @override
  String toString() {
    return '{"favorite": $favorite,"id": $id,"mediaId": $mediaId,"watchlist": $watchlist,"rated": $rated,"mediaType": ${mediaType != null ? '${json.encode(mediaType)}' : 'null'},"uid": ${uid != null ? '${json.encode(uid)}' : 'null'}}';
  }
}
