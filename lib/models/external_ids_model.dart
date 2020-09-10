import 'dart:convert' show json;

class ExternalIdsModel {

  int id;
  int tvdbId;
  int tvrageId;
  String facebookId;
  String freebaseId;
  String freebaseMid;
  String imdbId;
  String instagramId;
  String twitterId;

  ExternalIdsModel.fromParams({this.id, this.tvdbId, this.tvrageId, this.facebookId, this.freebaseId, this.freebaseMid, this.imdbId, this.instagramId, this.twitterId});

  factory ExternalIdsModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? new ExternalIdsModel.fromJson(json.decode(jsonStr)) : new ExternalIdsModel.fromJson(jsonStr);
  
  ExternalIdsModel.fromJson(jsonRes) {
    id = jsonRes['id'];
    tvdbId = jsonRes['tvdb_id'];
    tvrageId = jsonRes['tvrage_id'];
    facebookId = jsonRes['facebook_id'];
    freebaseId = jsonRes['freebase_id'];
    freebaseMid = jsonRes['freebase_mid'];
    imdbId = jsonRes['imdb_id'];
    instagramId = jsonRes['instagram_id'];
    twitterId = jsonRes['twitter_id'];
  }

  @override
  String toString() {
    return '{"id": $id,"tvdb_id": $tvdbId,"tvrage_id": $tvrageId,"facebook_id": ${facebookId != null?'${json.encode(facebookId)}':'null'},"freebase_id": ${freebaseId != null?'${json.encode(freebaseId)}':'null'},"freebase_mid": ${freebaseMid != null?'${json.encode(freebaseMid)}':'null'},"imdb_id": ${imdbId != null?'${json.encode(imdbId)}':'null'},"instagram_id": ${instagramId != null?'${json.encode(instagramId)}':'null'},"twitter_id": ${twitterId != null?'${json.encode(twitterId)}':'null'}}';
  }
}

