import 'dart:convert' show json;

class UserPremiumModel {
  bool status;
  String message;
  UserPremiumData data;

  UserPremiumModel.fromParams({this.status, this.message, this.data});

  factory UserPremiumModel(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new UserPremiumModel.fromJson(json.decode(jsonStr))
          : new UserPremiumModel.fromJson(jsonStr);

  UserPremiumModel.fromJson(jsonRes) {
    status = jsonRes['status'];
    message = jsonRes['message'];
    data = jsonRes['data'] == null
        ? null
        : new UserPremiumData.fromJson(jsonRes['data']);
  }

  @override
  String toString() {
    return '{"status": $status,"message": ${message != null ? '${json.encode(message)}' : 'null'},"data": $data}';
  }
}

class UserPremiumData {
  int id;
  String expireDate;
  String startDate;
  String uid;

  UserPremiumData.fromParams(
      {this.id, this.expireDate, this.startDate, this.uid});

  UserPremiumData.fromJson(jsonRes) {
    id = jsonRes['id'];
    expireDate = jsonRes['expireDate'];
    startDate = jsonRes['startDate'];
    uid = jsonRes['uid'];
  }

  @override
  String toString() {
    return '{"id": $id,"expireDate": ${expireDate != null ? '${json.encode(expireDate)}' : 'null'},"startDate": ${startDate != null ? '${json.encode(startDate)}' : 'null'},"uid": ${uid != null ? '${json.encode(uid)}' : 'null'}}';
  }
}
