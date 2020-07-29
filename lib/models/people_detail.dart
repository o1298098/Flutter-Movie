import 'dart:convert' show json;

import 'image_model.dart';

class PeopleDetailModel {
  Object deathday;
  Object homepage;
  int gender;
  int id;
  double popularity;
  bool adult;
  String biography;
  String birthday;
  String imdbId;
  String knownForDepartment;
  String name;
  String placeOfBirth;
  String profilePath;
  ProfileImages images;

  List<String> alsoKnownAs;

  PeopleDetailModel.fromParams(
      {this.deathday,
      this.homepage,
      this.gender,
      this.id,
      this.popularity,
      this.adult,
      this.biography,
      this.birthday,
      this.imdbId,
      this.knownForDepartment,
      this.name,
      this.placeOfBirth,
      this.profilePath,
      this.alsoKnownAs,
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
    imdbId = jsonRes['imdb_id'];
    knownForDepartment = jsonRes['known_for_department'];
    name = jsonRes['name'];
    placeOfBirth = jsonRes['place_of_birth'];
    profilePath = jsonRes['profile_path'];
    alsoKnownAs = jsonRes['also_known_as'] == null ? null : [];
    images = jsonRes['images'] == null
        ? null
        : new ProfileImages.fromJson(jsonRes['images']);
    for (var also_known_asItem
        in alsoKnownAs == null ? [] : jsonRes['also_known_as']) {
      alsoKnownAs.add(also_known_asItem);
    }
  }

  @override
  String toString() {
    return '{"deathday": $deathday,"homepage": $homepage,"gender": $gender,"id": $id,"popularity": $popularity,"adult": $adult,"biography": ${biography != null ? '${json.encode(biography)}' : 'null'},"birthday": ${birthday != null ? '${json.encode(birthday)}' : 'null'},"imdb_id": ${imdbId != null ? '${json.encode(imdbId)}' : 'null'},"known_for_department": ${knownForDepartment != null ? '${json.encode(knownForDepartment)}' : 'null'},"name": ${name != null ? '${json.encode(name)}' : 'null'},"place_of_birth": ${placeOfBirth != null ? '${json.encode(placeOfBirth)}' : 'null'},"profile_path": ${profilePath != null ? '${json.encode(profilePath)}' : 'null'},"also_known_as": $alsoKnownAs,"images": $images}';
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
