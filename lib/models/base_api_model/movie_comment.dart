import 'dart:convert' show json;

import 'base_user.dart';

class MovieComments {
  int page;
  int totalCount;
  List<MovieComment> data;

  MovieComments.fromParams({this.page, this.data, this.totalCount});

  factory MovieComments(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new MovieComments.fromJson(json.decode(jsonStr))
          : new MovieComments.fromJson(jsonStr);

  MovieComments.fromJson(jsonRes) {
    page = jsonRes['page'];
    totalCount = jsonRes['totalCount'];
    data = jsonRes['data'] == null ? null : [];

    for (var dataItem in data == null ? [] : jsonRes['data']) {
      data.add(dataItem == null ? null : new MovieComment.fromJson(dataItem));
    }
  }

  @override
  String toString() {
    return '{"page": $page,"totalCount": $totalCount,"data": $data}';
  }
}

class MovieComment {
  Object mainId;
  int id;
  int like;
  int mediaId;
  String comment;
  String createTime;
  String uid;
  String updateTime;
  BaseUser u;

  MovieComment.fromParams(
      {this.mainId,
      this.id,
      this.like,
      this.mediaId,
      this.comment,
      this.createTime,
      this.uid,
      this.updateTime,
      this.u});

  MovieComment.fromJson(jsonRes) {
    mainId = jsonRes['mainId'];
    id = jsonRes['id'];
    like = jsonRes['like'];
    mediaId = jsonRes['mediaId'];
    comment = jsonRes['comment'];
    createTime = jsonRes['createTime'];
    uid = jsonRes['uid'];
    updateTime = jsonRes['updateTime'];
    u = jsonRes['u'] == null ? null : new BaseUser.fromJson(jsonRes['u']);
  }

  @override
  String toString() {
    return '{"mainId": $mainId,"id": $id,"like": $like,"mediaId": $mediaId,"comment": ${comment != null ? '${json.encode(comment)}' : 'null'},"createTime": ${createTime != null ? '${json.encode(createTime)}' : 'null'},"uid": ${uid != null ? '${json.encode(uid)}' : 'null'},"updateTime": ${updateTime != null ? '${json.encode(updateTime)}' : 'null'},"u": $u}';
  }
}
