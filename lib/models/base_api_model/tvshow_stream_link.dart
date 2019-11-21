import 'dart:convert' show json;

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
  StreamLinkType streamLinkType;

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
    return '{"episode": $episode,"language": $language,"quality": $quality,"season": $season,"sid": $sid,"streamLinkType": ${streamLink != null ? '${json.encode(streamLink)}' : 'null'}Type,"tvId": $tvId,"linkName": ${linkName != null ? '${json.encode(linkName)}' : 'null'},"streamLink": ${streamLink != null ? '${json.encode(streamLink)}' : 'null'},"uid": ${uid != null ? '${json.encode(uid)}' : 'null'},"updateTime": ${updateTime != null ? '${json.encode(updateTime)}' : 'null'},"languageNavigation": $language,"qualityNavigation": $quality,"streamLinkTypeNavigation": $streamLinkType}';
  }
}

class StreamLinkType {
  int id;
  String name;

  StreamLinkType.fromParams({this.id, this.name});

  StreamLinkType.fromJson(jsonRes) {
    id = jsonRes['id'];
    name = jsonRes['name'];
  }

  @override
  String toString() {
    return '{"id": $id,"name": ${name != null ? '${json.encode(name)}' : 'null'}}';
  }
}

class Quality {
  int id;
  String code;
  String name;

  Quality.fromParams({this.id, this.code, this.name});

  Quality.fromJson(jsonRes) {
    id = jsonRes['id'];
    code = jsonRes['code'];
    name = jsonRes['name'];
  }

  @override
  String toString() {
    return '{"id": $id,"code": ${code != null ? '${json.encode(code)}' : 'null'},"name": ${name != null ? '${json.encode(name)}' : 'null'}}';
  }
}

class Language {
  int id;
  String code;
  String name;

  Language.fromParams({this.id, this.code, this.name});

  Language.fromJson(jsonRes) {
    id = jsonRes['id'];
    code = jsonRes['code'];
    name = jsonRes['name'];
  }

  @override
  String toString() {
    return '{"id": $id,"code": ${code != null ? '${json.encode(code)}' : 'null'},"name": ${name != null ? '${json.encode(name)}' : 'null'}}';
  }
}
