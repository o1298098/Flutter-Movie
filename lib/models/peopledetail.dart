import 'dart:convert' show json;

import 'imagemodel.dart';

class PeopleDetailModel {
  Object deathday;
  Object homepage;
  int gender;
  int id;
  double popularity;
  bool adult;
  String biography;
  String birthday;
  String imdb_id;
  String known_for_department;
  String name;
  String place_of_birth;
  String profile_path;
  ProfileImages images;

  List<String> also_known_as;

  PeopleDetailModel.fromParams(
      {this.deathday,
      this.homepage,
      this.gender,
      this.id,
      this.popularity,
      this.adult,
      this.biography,
      this.birthday,
      this.imdb_id,
      this.known_for_department,
      this.name,
      this.place_of_birth,
      this.profile_path,
      this.also_known_as,
      this.images});

  factory PeopleDetailModel(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new PeopleDetailModel.fromJson(json.decode(jsonStr))
          : new PeopleDetailModel.fromJson(jsonStr);

  PeopleDetailModel.fromJson(jsonRes) {
    deathday = jsonRes['deathday'];
    homepage = jsonRes['homepage'];
    gender = jsonRes['gender'];
    id = jsonRes['id'];
    popularity = jsonRes['popularity'];
    adult = jsonRes['adult'];
    biography = jsonRes['biography'];
    birthday = jsonRes['birthday'];
    imdb_id = jsonRes['imdb_id'];
    known_for_department = jsonRes['known_for_department'];
    name = jsonRes['name'];
    place_of_birth = jsonRes['place_of_birth'];
    profile_path = jsonRes['profile_path'];
    also_known_as = jsonRes['also_known_as'] == null ? null : [];
    images = jsonRes['images'] == null
        ? null
        : new ProfileImages.fromJson(jsonRes['images']);
    for (var also_known_asItem
        in also_known_as == null ? [] : jsonRes['also_known_as']) {
      also_known_as.add(also_known_asItem);
    }
  }

  @override
  String toString() {
    return '{"deathday": $deathday,"homepage": $homepage,"gender": $gender,"id": $id,"popularity": $popularity,"adult": $adult,"biography": ${biography != null ? '${json.encode(biography)}' : 'null'},"birthday": ${birthday != null ? '${json.encode(birthday)}' : 'null'},"imdb_id": ${imdb_id != null ? '${json.encode(imdb_id)}' : 'null'},"known_for_department": ${known_for_department != null ? '${json.encode(known_for_department)}' : 'null'},"name": ${name != null ? '${json.encode(name)}' : 'null'},"place_of_birth": ${place_of_birth != null ? '${json.encode(place_of_birth)}' : 'null'},"profile_path": ${profile_path != null ? '${json.encode(profile_path)}' : 'null'},"also_known_as": $also_known_as,"images": $images}';
  }
}

class ProfileImages {
  List<ImageData> profiles;

  ProfileImages.fromParams({this.profiles});

  ProfileImages.fromJson(jsonRes) {
    profiles = jsonRes['profiles'] == null ? null : [];

    for (var profilesItem in profiles == null ? [] : jsonRes['profiles']) {
      profiles.add(
          profilesItem == null ? null : new ImageData.fromJson(profilesItem));
    }
  }

  @override
  String toString() {
    return '{"profiles": $profiles}';
  }
}
