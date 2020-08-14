import 'dart:convert' show json;

class AccountInfo {
  int castLists;
  int favorites;
  int myLists;
  int watchLists;
  String uid;

  AccountInfo.fromParams(
      {this.castLists,
      this.favorites,
      this.myLists,
      this.watchLists,
      this.uid});

  factory AccountInfo(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new AccountInfo.fromJson(json.decode(jsonStr))
          : new AccountInfo.fromJson(jsonStr);

  AccountInfo.fromJson(jsonRes) {
    castLists = jsonRes['castLists'];
    favorites = jsonRes['favorites'];
    myLists = jsonRes['myLists'];
    watchLists = jsonRes['watchLists'];
    uid = jsonRes['uid'];
  }

  @override
  String toString() {
    return '{"castLists": $castLists,"favorites": $favorites,"myLists": $myLists,"watchLists": $watchLists,"uid": ${uid != null ? '${json.encode(uid)}' : 'null'}}';
  }
}
