import 'dart:convert' show json;

class TvShowLikeModel {
  int episode;
  int id;
  int season;
  int tvId;
  String uid;

  TvShowLikeModel.fromParams(
      {this.episode, this.id, this.season, this.tvId, this.uid});

  factory TvShowLikeModel(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new TvShowLikeModel.fromJson(json.decode(jsonStr))
          : new TvShowLikeModel.fromJson(jsonStr);

  TvShowLikeModel.fromJson(jsonRes) {
    episode = jsonRes['episode'];
    id = jsonRes['id'];
    season = jsonRes['season'];
    tvId = jsonRes['tvId'];
    uid = jsonRes['uid'];
  }

  @override
  String toString() {
    return '{"episode": $episode,"id": $id,"season": $season,"tvId": $tvId,"uid": ${uid != null ? '${json.encode(uid)}' : 'null'}}';
  }
}
