import 'dart:convert' show json;

class UserListModel {
  List<UserList> data;
  int page;

  UserListModel.fromParams({this.data});

  factory UserListModel(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new UserListModel.fromJson(json.decode(jsonStr))
          : new UserListModel.fromJson(jsonStr);

  UserListModel.fromJson(jsonRes) {
    data = jsonRes['data'] == null ? null : [];
    page = jsonRes['page'];
    for (var listItem in data == null ? [] : jsonRes['data']) {
      data.add(listItem == null ? null : new UserList.fromJson(listItem));
    }
  }

  @override
  String toString() {
    return '{"page":$page,"data": $data}';
  }
}

class UserList {
  int id;
  int itemCount;
  int runTime;
  int selected;
  double revenue;
  double totalRated;
  String backGroundUrl;
  String createTime;
  String description;
  String listName;
  String uid;
  String updateTime;

  UserList.fromParams(
      {this.id,
      this.itemCount,
      this.runTime,
      this.selected,
      this.revenue,
      this.totalRated,
      this.backGroundUrl,
      this.createTime,
      this.description,
      this.listName,
      this.uid,
      this.updateTime});

  UserList.fromJson(jsonRes) {
    id = jsonRes['id'];
    itemCount = jsonRes['itemCount'];
    runTime = jsonRes['runTime'];
    selected = jsonRes['selected'];
    revenue = jsonRes['revenue'];
    totalRated = jsonRes['totalRated'];
    backGroundUrl = jsonRes['backGroundUrl'];
    createTime = jsonRes['createTime'];
    description = jsonRes['description'];
    listName = jsonRes['listName'];
    uid = jsonRes['uid'];
    updateTime = jsonRes['updateTime'];
  }

  @override
  String toString() {
    return '{"id": $id,"itemCount": $itemCount,"runTime": $runTime,"selected": $selected,"revenue": $revenue,"totalRated": $totalRated,"backGroundUrl": ${backGroundUrl != null ? '${json.encode(backGroundUrl)}' : 'null'},"createTime": ${createTime != null ? '${json.encode(createTime)}' : 'null'},"description": ${description != null ? '${json.encode(description)}' : 'null'},"listName": ${listName != null ? '${json.encode(listName)}' : 'null'},"uid": ${uid != null ? '${json.encode(uid)}' : 'null'},"updateTime": ${updateTime != null ? '${json.encode(updateTime)}' : 'null'}}';
  }
}
