import 'dart:convert' show json;

class CastListModel {
  List<BaseCastList> list;

  CastListModel.fromParams({this.list});

  factory CastListModel(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new CastListModel.fromJson(json.decode(jsonStr))
          : new CastListModel.fromJson(jsonStr);

  CastListModel.fromJson(jsonRes) {
    list = jsonRes['castList'] == null ? null : [];

    for (var listItem in list == null ? [] : jsonRes['castList']) {
      list.add(listItem == null ? null : new BaseCastList.fromJson(listItem));
    }
  }

  CastListModel.fromMap(jsonRes) {
    list = jsonRes['castList'] == null ? null : [];

    for (var listItem in list == null ? [] : jsonRes['castList']) {
      list.add(listItem == null ? null : new BaseCastList.fromJson(listItem));
    }
  }

  @override
  String toString() {
    return '{"castList": $list}';
  }
}

class BaseCastList {
  String backgroundUrl;
  int id;
  bool selected;
  DateTime createTime;
  String description;
  String name;
  String uid;
  DateTime updateTime;
  int castCount;

  BaseCastList.fromParams(
      {this.backgroundUrl,
      this.id,
      this.selected,
      this.createTime,
      this.description,
      this.name,
      this.uid,
      this.updateTime,
      this.castCount = 0});

  BaseCastList.fromJson(jsonRes) {
    backgroundUrl = jsonRes['backgroundUrl'];
    id = int.parse(jsonRes['id']);
    selected = jsonRes['selected'] == '1';
    createTime =
        DateTime.parse(jsonRes['createTime']?.toString() ?? '1990-01-01');
    description = jsonRes['description'];
    name = jsonRes['name'];
    uid = jsonRes['uid'];
    updateTime =
        DateTime.parse(jsonRes['updateTime']?.toString() ?? '1990-01-01');
    castCount = int.parse(jsonRes['castCount']?.toString() ?? '0');
  }

  @override
  String toString() {
    return '{"backGroundUrl": ${backgroundUrl != null ? '${json.encode(backgroundUrl)}' : 'null'},"id": $id,"selected": $selected,"createTime": $createTime,"description": ${description != null ? '${json.encode(description)}' : 'null'},"name": ${name != null ? '${json.encode(name)}' : 'null'},"uid": ${uid != null ? '${json.encode(uid)}' : 'null'},"updateTime": $updateTime,"castCount": $castCount}';
  }
}
