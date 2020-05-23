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
  int premiumType;
  bool subscription;
  String expireDate;
  String startDate;
  String subscriptionId;
  String uid;

  UserPremiumData.fromParams(
      {this.id,
      this.premiumType,
      this.subscription,
      this.expireDate,
      this.startDate,
      this.subscriptionId,
      this.uid});

  factory UserPremiumData(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new UserPremiumData.fromJson(json.decode(jsonStr))
          : new UserPremiumData.fromJson(jsonStr);

  UserPremiumData.fromJson(jsonRes) {
    id = jsonRes['id'];
    premiumType = jsonRes['premiumType'];
    subscription = jsonRes['subscription'] == 1;
    expireDate = jsonRes['expireDate'];
    startDate = jsonRes['startDate'];
    subscriptionId = jsonRes['subscriptionId'];
    uid = jsonRes['uid'];
  }

  @override
  String toString() {
    return '{"id": $id,"premiumType": $premiumType,"subscription": ${subscription ? '1' : '0'},"expireDate": ${expireDate != null ? '${json.encode(expireDate)}' : 'null'},"startDate": ${startDate != null ? '${json.encode(startDate)}' : 'null'},"uid": ${uid != null ? '${json.encode(uid)}' : 'null'},"subscriptionId": ${subscriptionId != null ? '${json.encode(subscriptionId)}' : 'null'}}';
  }
}
