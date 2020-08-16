import 'dart:convert' show json;

import 'stream_link_language.dart';
import 'stream_link_quality.dart';
import 'stream_link_type.dart';

class MovieStreamLinks {
  List<MovieStreamLink> list;

  MovieStreamLinks.fromParams({this.list});

  factory MovieStreamLinks(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new MovieStreamLinks.fromJson(json.decode(jsonStr))
          : new MovieStreamLinks.fromJson(jsonStr);

  MovieStreamLinks.fromJson(jsonRes) {
    list = jsonRes == null ? null : [];

    for (var listItem in list == null ? [] : jsonRes) {
      list.add(
          listItem == null ? null : new MovieStreamLink.fromJson(listItem));
    }
  }

  @override
  String toString() {
    return '{"json_list": $list}';
  }
}

class MovieStreamLink {
  int movieId;
  int sid;
  String linkName;
  String streamLink;
  String uid;
  String updateTime;
  Language language;
  Quality quality;
  StreamLinkType streamLinkType;
  bool selected;
  bool needAd;
  bool externalBrowser;

  MovieStreamLink.fromParams(
      {this.language,
      this.movieId,
      this.quality,
      this.sid,
      this.streamLinkType,
      this.linkName,
      this.streamLink,
      this.uid,
      this.updateTime,
      this.needAd,
      this.externalBrowser});

  MovieStreamLink.fromJson(jsonRes) {
    movieId = jsonRes['movieId'];
    sid = jsonRes['sid'];
    linkName = jsonRes['linkName'];
    streamLink = jsonRes['streamLink'];
    uid = jsonRes['uid'];
    updateTime = jsonRes['updateTime'];
    needAd = jsonRes['needAd'] == 1;
    externalBrowser = jsonRes['externalBrowser'] == 1;
    selected = false;
    language = jsonRes['languageNavigation'] == null
        ? null
        : new Language.fromJson(jsonRes['languageNavigation']);
    quality = jsonRes['qualityNavigation'] == null
        ? null
        : new Quality.fromJson(jsonRes['qualityNavigation']);
    streamLinkType = jsonRes['streamLinkTypeNavigation'] == null
        ? null
        : new StreamLinkType.fromJson(jsonRes['streamLinkTypeNavigation']);
  }

  @override
  String toString() {
    return '{"language": $language,"movieId": $movieId,"quality": $quality,"sid": $sid,"streamLinkType": ${streamLink != null ? '${json.encode(streamLink)}' : 'null'}Type,"linkName": ${linkName != null ? '${json.encode(linkName)}' : 'null'},"streamLink": ${streamLink != null ? '${json.encode(streamLink)}' : 'null'},"uid": ${uid != null ? '${json.encode(uid)}' : 'null'},"updateTime": ${updateTime != null ? '${json.encode(updateTime)}' : 'null'},"languageNavigation": $language,"qualityNavigation": $quality,"streamLinkTypeNavigation": $streamLinkType,"needAd": $needAd,"externalBrowser": $externalBrowser}';
  }
}
