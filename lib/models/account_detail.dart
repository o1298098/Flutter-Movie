import 'dart:convert' show json;

class AccountDetailModel {

  int id;
  bool includeAdult;
  String iso31661;
  String iso6391;
  String name;
  String username;
  Avatar avatar;

  AccountDetailModel.fromParams({this.id, this.includeAdult, this.iso31661, this.iso6391, this.name, this.username, this.avatar});

  factory AccountDetailModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? new AccountDetailModel.fromJson(json.decode(jsonStr)) : new AccountDetailModel.fromJson(jsonStr);
  
  AccountDetailModel.fromJson(jsonRes) {
    id = jsonRes['id'];
    includeAdult = jsonRes['include_adult'];
    iso31661 = jsonRes['iso_3166_1'];
    iso6391 = jsonRes['iso_639_1'];
    name = jsonRes['name'];
    username = jsonRes['username'];
    avatar = jsonRes['avatar'] == null ? null : new Avatar.fromJson(jsonRes['avatar']);
  }

  @override
  String toString() {
    return '{"id": $id,"include_adult": $includeAdult,"iso_3166_1": ${iso31661 != null?'${json.encode(iso31661)}':'null'},"iso_639_1": ${iso6391 != null?'${json.encode(iso6391)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'},"username": ${username != null?'${json.encode(username)}':'null'},"avatar": $avatar}';
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

