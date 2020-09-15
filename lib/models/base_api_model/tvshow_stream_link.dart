import 'dart:convert' show json;

import 'stream_link_language.dart';
import 'stream_link_quality.dart';
import 'stream_link_type.dart';

class TvShowStreamLinks {
  List<TvShowStreamLink> list;

  TvShowStreamLinks.fromParams({this.list});

  factory TvShowStreamLinks(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new TvShowStreamLinks.fromJson(json.decode(jsonStr))
          : new TvShowStreamLinks.fromJson(jsonStr);

  TvShowStreamLinks.fromJson(jsonRes) {
    list = jsonRes == null ? null : [];

    for (var listItem in list == null ? [] : jsonRes) {
      list.add(
          listItem == null ? null : new TvShowStreamLink.fromJson(listItem));
    }
  }

  @override
  String toString() {
    return '{"json_list": $list}';
  }
}

class TvShowStreamLink {
  int episode;
  int season;
  int sid;
  int tvId;
  String linkName;
  String streamLink;
  String uid;
  String updateTime;
  Language language;
  Quality quality;
  bool needAd;
  bool externalBrowser;
  StreamLinkType streamLinkType;
  factory TvShowStreamLink(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new TvShowStreamLink.fromJson(json.decode(jsonStr))
          : new TvShowStreamLink.fromJson(jsonStr);
  TvShowStreamLink.fromParams(
      {this.episode,
      this.language,
      this.quality,
      this.season,
      this.sid,
      this.streamLinkType,
      this.tvId,
      this.linkName,
      this.streamLink,
      this.uid,
      this.needAd,
      this.externalBrowser,
      this.updateTime});

  TvShowStreamLink.fromJson(jsonRes) {
    episode = jsonRes['episode'];
    season = jsonRes['season'];
    sid = jsonRes['sid'];
    tvId = jsonRes['tvId'];
    linkName = jsonRes['linkName'];
    streamLink = jsonRes['streamLink'];
    uid = jsonRes['uid'];
    updateTime = jsonRes['updateTime'];
    needAd = jsonRes['needAd'] == 1;
    externalBrowser = jsonRes['externalBrowser'] == 1;
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
    return '{"episode": $episode,"season": $season,"sid": $sid,"streamLink": ${streamLink != null ? '${json.encode(streamLink)}' : 'null'},"tvId": $tvId,"linkName": ${linkName != null ? '${json.encode(linkName)}' : 'null'},"streamLink": ${streamLink != null ? '${json.encode(streamLink)}' : 'null'},"uid": ${uid != null ? '${json.encode(uid)}' : 'null'},"updateTime": ${updateTime != null ? '${json.encode(updateTime)}' : 'null'},"languageNavigation": $language,"qualityNavigation": $quality,"streamLinkTypeNavigation": $streamLinkType,"needAd":$needAd,"externalBrowser":$externalBrowser}';
  }
}
