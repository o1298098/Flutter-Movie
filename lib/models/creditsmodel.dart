import 'dart:convert' show json;

class CreditsModel {

  int id;
  List<CastData> cast;
  List<CrewData> crew;
  List<CastData> guest_stars;

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
    guest_stars = jsonRes['guest_stars'] == null ? null : [];

    for (var guest_starsItem in guest_stars == null ? [] : jsonRes['guest_stars']){
            guest_stars.add(guest_starsItem == null ? null : new CastData.fromJson(guest_starsItem));
    }
  }

  @override
  String toString() {
    return '{"id": $id,"cast": $cast,"crew": $crew,"guest_stars": $guest_stars}';
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

  int id;
  int vote_count;
  double popularity;
  double vote_average;
  bool adult;
  bool video;
  String profile_path;
  String backdrop_path;
  String character;
  String credit_id;
  String original_language;
  String original_title;
  String overview;
  String poster_path;
  String release_date;
  String title;
  String name;
  List<int> genre_ids;

  CastData.fromParams({this.id, this.vote_count, this.name,this.profile_path,this.popularity, this.vote_average, this.adult, this.video, this.backdrop_path, this.character, this.credit_id, this.original_language, this.original_title, this.overview, this.poster_path, this.release_date, this.title, this.genre_ids});
  
  CastData.fromJson(jsonRes) {
    id = jsonRes['id'];
    vote_count = jsonRes['vote_count'];
    popularity = double.parse(jsonRes['popularity']?.toString()??'0');
    vote_average =double.parse(jsonRes['vote_average']?.toString()??'0') ;
    adult = jsonRes['adult'];
    video = jsonRes['video'];
    name = jsonRes['name'];
    backdrop_path = jsonRes['backdrop_path'];
    character = jsonRes['character'];
    credit_id = jsonRes['credit_id'];
    original_language = jsonRes['original_language'];
    original_title = jsonRes['original_title'];
    overview = jsonRes['overview'];
    poster_path = jsonRes['poster_path'];
    release_date = jsonRes['release_date'];
    title = jsonRes['title'];
    profile_path=jsonRes['profile_path'];
    genre_ids = jsonRes['genre_ids'] == null ? null : [];

    for (var genre_idsItem in genre_ids == null ? [] : jsonRes['genre_ids']){
            genre_ids.add(genre_idsItem);
    }
  }

  @override
  String toString() {
    return '{"id": $id,"vote_count": $vote_count,"profile_path":$profile_path,"name":$name,"popularity": $popularity,"vote_average": $vote_average,"adult": $adult,"video": $video,"backdrop_path": ${backdrop_path != null?'${json.encode(backdrop_path)}':'null'},"character": ${character != null?'${json.encode(character)}':'null'},"credit_id": ${credit_id != null?'${json.encode(credit_id)}':'null'},"original_language": ${original_language != null?'${json.encode(original_language)}':'null'},"original_title": ${original_title != null?'${json.encode(original_title)}':'null'},"overview": ${overview != null?'${json.encode(overview)}':'null'},"poster_path": ${poster_path != null?'${json.encode(poster_path)}':'null'},"release_date": ${release_date != null?'${json.encode(release_date)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'},"genre_ids": $genre_ids}';
  }
}

