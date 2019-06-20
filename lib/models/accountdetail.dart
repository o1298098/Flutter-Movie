import 'dart:convert' show json;

class AccountDetailModel {

  int id;
  bool include_adult;
  String iso_3166_1;
  String iso_639_1;
  String name;
  String username;
  Avatar avatar;

  AccountDetailModel.fromParams({this.id, this.include_adult, this.iso_3166_1, this.iso_639_1, this.name, this.username, this.avatar});

  factory AccountDetailModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? new AccountDetailModel.fromJson(json.decode(jsonStr)) : new AccountDetailModel.fromJson(jsonStr);
  
  AccountDetailModel.fromJson(jsonRes) {
    id = jsonRes['id'];
    include_adult = jsonRes['include_adult'];
    iso_3166_1 = jsonRes['iso_3166_1'];
    iso_639_1 = jsonRes['iso_639_1'];
    name = jsonRes['name'];
    username = jsonRes['username'];
    avatar = jsonRes['avatar'] == null ? null : new Avatar.fromJson(jsonRes['avatar']);
  }

  @override
  String toString() {
    return '{"id": $id,"include_adult": $include_adult,"iso_3166_1": ${iso_3166_1 != null?'${json.encode(iso_3166_1)}':'null'},"iso_639_1": ${iso_639_1 != null?'${json.encode(iso_639_1)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'},"username": ${username != null?'${json.encode(username)}':'null'},"avatar": $avatar}';
  }
}

class Avatar {

  Gravatar gravatar;

  Avatar.fromParams({this.gravatar});
  
  Avatar.fromJson(jsonRes) {
    gravatar = jsonRes['gravatar'] == null ? null : new Gravatar.fromJson(jsonRes['gravatar']);
  }

  @override
  String toString() {
    return '{"gravatar": $gravatar}';
  }
}

class Gravatar {

  String hash;

  Gravatar.fromParams({this.hash});
  
  Gravatar.fromJson(jsonRes) {
    hash = jsonRes['hash'];
  }

  @override
  String toString() {
    return '{"hash": ${hash != null?'${json.encode(hash)}':'null'}}';
  }
}

