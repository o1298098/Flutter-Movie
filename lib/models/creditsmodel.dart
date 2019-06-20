import 'dart:convert' show json;

class CreditsModel {

  int id;
  List<CastData> cast;
  List<CrewData> crew;

  CreditsModel.fromParams({this.id, this.cast, this.crew});

  factory CreditsModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? new CreditsModel.fromJson(json.decode(jsonStr)) : new CreditsModel.fromJson(jsonStr);
  
  CreditsModel.fromJson(jsonRes) {
    id = jsonRes['id'];
    cast = jsonRes['cast'] == null ? null : [];

    for (var castItem in cast == null ? [] : jsonRes['cast']){
            cast.add(castItem == null ? null : new CastData.fromJson(castItem));
    }

    crew = jsonRes['crew'] == null ? null : [];

    for (var crewItem in crew == null ? [] : jsonRes['crew']){
            crew.add(crewItem == null ? null : new CrewData.fromJson(crewItem));
    }
  }

  @override
  String toString() {
    return '{"id": $id,"cast": $cast,"crew": $crew}';
  }
}

class CrewData {

  int gender;
  int id;
  String credit_id;
  String department;
  String job;
  String name;
  String profile_path;

  CrewData.fromParams({this.gender, this.id, this.credit_id, this.department, this.job, this.name, this.profile_path});
  
  CrewData.fromJson(jsonRes) {
    gender = jsonRes['gender'];
    id = jsonRes['id'];
    credit_id = jsonRes['credit_id'];
    department = jsonRes['department'];
    job = jsonRes['job'];
    name = jsonRes['name'];
    profile_path = jsonRes['profile_path'];
  }

  @override
  String toString() {
    return '{"gender": $gender,"id": $id,"credit_id": ${credit_id != null?'${json.encode(credit_id)}':'null'},"department": ${department != null?'${json.encode(department)}':'null'},"job": ${job != null?'${json.encode(job)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'},"profile_path": ${profile_path != null?'${json.encode(profile_path)}':'null'}}';
  }
}

class CastData {

  int cast_id;
  int gender;
  int id;
  int order;
  String character;
  String credit_id;
  String name;
  String profile_path;

  CastData.fromParams({this.cast_id, this.gender, this.id, this.order, this.character, this.credit_id, this.name, this.profile_path});
  
  CastData.fromJson(jsonRes) {
    cast_id = jsonRes['cast_id'];
    gender = jsonRes['gender'];
    id = jsonRes['id'];
    order = jsonRes['order'];
    character = jsonRes['character'];
    credit_id = jsonRes['credit_id'];
    name = jsonRes['name'];
    profile_path = jsonRes['profile_path'];
  }

  @override
  String toString() {
    return '{"cast_id": $cast_id,"gender": $gender,"id": $id,"order": $order,"character": ${character != null?'${json.encode(character)}':'null'},"credit_id": ${credit_id != null?'${json.encode(credit_id)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'},"profile_path": ${profile_path != null?'${json.encode(profile_path)}':'null'}}';
  }
}

