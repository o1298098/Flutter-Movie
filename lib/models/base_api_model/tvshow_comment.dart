import 'dart:convert' show json;

import 'base_user.dart';

class TvShowComments {
  int page;
  int totalCount;
  List<TvShowComment> data;

  TvShowComments.fromParams({this.page, this.data, this.totalCount});

  factory TvShowComments(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new TvShowComments.fromJson(json.decode(jsonStr))
          : new TvShowComments.fromJson(jsonStr);

  TvShowComments.fromJson(jsonRes) {
    page = jsonRes['page'];
    totalCount = jsonRes['totalCount'];
    data = jsonRes['data'] == null ? null : [];

    for (var dataItem in data == null ? [] : jsonRes['data']) {
      data.add(dataItem == null ? null : new TvShowComment.fromJson(dataItem));
    }
  }

  @override
  String toString() {
    return '{"page": $page,"totalCount": $totalCount,"data": $data}';
  }
}

class TvShowComment {
  int episode;
  int id;
  int like;
  int mainId;
  int mediaId;
  int season;
  String comment;
  String createTime;
  String uid;
  String updateTime;
  BaseUser u;

  TvShowComment.fromParams(
      {this.episode,
      this.id,
      this.like,
      this.mainId,
      this.mediaId,
      this.season,
      this.comment,
      this.createTime,
      this.uid,
      this.updateTime,
      this.u});

  TvShowComment.fromJson(jsonRes) {
    episode = jsonRes['episode'];
    id = jsonRes['id'];
    like = jsonRes['like'];
    mainId = jsonRes['mainId'];
    mediaId = jsonRes['mediaId'];
    season = jsonRes['season'];
    comment = jsonRes['comment'];
    createTime = jsonRes['createTime'];
    uid = jsonRes['uid'];
    updateTime = jsonRes['updateTime'];
    u = jsonRes['u'] == null ? null : new BaseUser.fromJson(jsonRes['u']);
  }

  @override
  String toString() {
    return '{"episode": $episode,"id": $id,"like": $like,"mainId": $mainId,"mediaId": $mediaId,"season": $season,"comment": ${comment != null ? '${json.encode(comment)}' : 'null'},"createTime": ${createTime != null ? '${json.encode(createTime)}' : 'null'},"uid": ${uid != null ? '${json.encode(uid)}' : 'null'},"updateTime": ${updateTime != null ? '${json.encode(updateTime)}' : 'null'},"u": $u}';
  }
}
