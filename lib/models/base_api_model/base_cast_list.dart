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
  String backGroundUrl;
  int id;
  bool selected;
  DateTime createTime;
  String description;
  String name;
  String uid;
  DateTime updateTime;
  int castCount;

  BaseCastList.fromParams(
      {this.backGroundUrl,
      this.id,
      this.selected,
      this.createTime,
      this.description,
      this.name,
      this.uid,
      this.updateTime,
      this.castCount = 0});

  BaseCastList.fromJson(jsonRes) {
    backGroundUrl = jsonRes['backGroundUrl'];
    id = int.parse(jsonRes['id']);
    selected = jsonRes['selected'] == '1';
    createTime = DateTime.parse(jsonRes['createTime'] ?? '1990-01-01');
    description = jsonRes['description'];
    name = jsonRes['name'];
    uid = jsonRes['uid'];
    updateTime = DateTime.parse(jsonRes['updateTime'] ?? '1990-01-01');
    castCount = int.parse(jsonRes['castCount'].toString());
  }

  @override
  String toString() {
    return '{"backGroundUrl": ${backGroundUrl != null ? '${json.encode(backGroundUrl)}' : 'null'},"id": $id,"selected": $selected,"createTime": ${createTime != null ? '${json.encode(createTime)}' : 'null'},"description": ${description != null ? '${json.encode(description)}' : 'null'},"name": ${name != null ? '${json.encode(name)}' : 'null'},"uid": ${uid != null ? '${json.encode(uid)}' : 'null'},"updateTime": ${updateTime != null ? '${json.encode(updateTime)}' : 'null'},"castCount": $castCount}';
  }
}
