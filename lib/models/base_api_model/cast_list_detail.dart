import 'dart:convert' show json;

class CastListDetail {
  int page;
  List<BaseCast> data;

  CastListDetail.fromParams({this.page, this.data});

  factory CastListDetail(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new CastListDetail.fromJson(json.decode(jsonStr))
          : new CastListDetail.fromJson(jsonStr);

  CastListDetail.fromJson(jsonRes) {
    page = jsonRes['page'];
    data = jsonRes['data'] == null ? null : [];

    for (var dataItem in data == null ? [] : jsonRes['data']) {
      data.add(dataItem == null ? null : new BaseCast.fromJson(dataItem));
    }
  }

  @override
  String toString() {
    return '{"page": $page,"data": $data}';
  }
}

class BaseCast {
  int castId;
  int id;
  int listId;
  String name;
  String profileUrl;
  DateTime updateTime;

  BaseCast.fromParams(
      {this.castId,
      this.id,
      this.listId,
      this.name,
      this.profileUrl,
      this.updateTime});

  BaseCast.fromJson(jsonRes) {
    castId = jsonRes['castId'];
    id = jsonRes['id'];
    listId = jsonRes['listId'];
    name = jsonRes['name'];
    profileUrl = jsonRes['profileUrl'];
    updateTime =
        DateTime.parse(jsonRes['updateTime']?.toString() ?? '2020-01-01');
  }

  @override
  String toString() {
    return '{"castId": $castId,"id": $id,"listId": $listId,"name": ${name != null ? '${json.encode(name)}' : 'null'},"profileUrl": ${profileUrl != null ? '${json.encode(profileUrl)}' : 'null'},"updateTime": $updateTime}';
  }
}
