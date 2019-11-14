import 'dart:convert' show json;

class UserListDetailModel {
  int page;
  List<UserListDetail> data;

  UserListDetailModel.fromParams({this.page, this.data});

  factory UserListDetailModel(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new UserListDetailModel.fromJson(json.decode(jsonStr))
          : new UserListDetailModel.fromJson(jsonStr);

  UserListDetailModel.fromJson(jsonRes) {
    page = jsonRes['page'];
    data = jsonRes['data'] == null ? null : [];

    for (var dataItem in data == null ? [] : jsonRes['data']) {
      data.add(dataItem == null ? null : new UserListDetail.fromJson(dataItem));
    }
  }

  @override
  String toString() {
    return '{"page": $page,"data": $data}';
  }
}

class UserListDetail {
  int id;
  int listid;
  int mediaid;
  int runTime;
  double rated;
  double revenue;
  String mediaName;
  String mediaType;
  String photoUrl;

  UserListDetail.fromParams(
      {this.id,
      this.listid,
      this.mediaid,
      this.runTime,
      this.rated,
      this.revenue,
      this.mediaName,
      this.mediaType,
      this.photoUrl});

  UserListDetail.fromJson(jsonRes) {
    id = jsonRes['id'];
    listid = jsonRes['listid'];
    mediaid = jsonRes['mediaid'];
    runTime = jsonRes['runTime'];
    rated = double.parse(jsonRes['rated'].toString() ?? '0.0');
    revenue = double.parse(jsonRes['revenue']?.toString() ?? '0.0');
    mediaName = jsonRes['mediaName'];
    mediaType = jsonRes['mediaType'];
    photoUrl = jsonRes['photoUrl'];
  }

  @override
  String toString() {
    return '{"id": $id,"listid": $listid,"mediaid": $mediaid,"runTime": $runTime,"rated": $rated,"revenue": $revenue,"mediaName": ${mediaName != null ? '${json.encode(mediaName)}' : 'null'},"mediaType": ${mediaType != null ? '${json.encode(mediaType)}' : 'null'},"photoUrl": ${photoUrl != null ? '${json.encode(photoUrl)}' : 'null'}}';
  }
}
