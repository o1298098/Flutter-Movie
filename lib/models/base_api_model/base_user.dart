import 'dart:convert' show json;

class BaseUser {
  int isAdmin;
  String phone;
  String email;
  String photoUrl;
  String uid;
  String userName;

  BaseUser.fromParams(
      {this.isAdmin,
      this.phone,
      this.email,
      this.photoUrl,
      this.uid,
      this.userName});

  BaseUser.fromJson(jsonRes) {
    isAdmin = jsonRes['isAdmin'];
    phone = jsonRes['phone'];
    email = jsonRes['email'];
    photoUrl = jsonRes['photoUrl'];
    uid = jsonRes['uid'];
    userName = jsonRes['userName'];
  }

  @override
  String toString() {
    return '{"isAdmin": $isAdmin,"phone": ${phone != null ? '${json.encode(phone)}' : 'null'},"email": ${email != null ? '${json.encode(email)}' : 'null'},"photoUrl": ${photoUrl != null ? '${json.encode(photoUrl)}' : 'null'},"uid": ${uid != null ? '${json.encode(uid)}' : 'null'},"userName": ${userName != null ? '${json.encode(userName)}' : 'null'}}';
  }
}
