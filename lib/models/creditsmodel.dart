import 'dart:convert' show json;

class CreditsModel {

  int id;
  List<CastData> cast;
  List<CrewData> crew;
  List<CastData> guestStars;

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
    guestStars = jsonRes['guest_stars'] == null ? null : [];

    for (var guest_starsItem in guestStars == null ? [] : jsonRes['guest_stars']){
            guestStars.add(guest_starsItem == null ? null : new CastData.fromJson(guest_starsItem));
    }
  }

  @override
  String toString() {
    return '{"id": $id,"cast": $cast,"crew": $crew,"guest_stars": $guestStars}';
  }
}

class CrewData {

  int gender;
  int id;
  String creditId;
  String department;
  String job;
  String name;
  String profilePath;

  CrewData.fromParams({this.gender, this.id, this.creditId, this.department, this.job, this.name, this.profilePath});
  
  CrewData.fromJson(jsonRes) {
    gender = jsonRes['gender'];
    id = jsonRes['id'];
    creditId = jsonRes['credit_id'];
    department = jsonRes['department'];
    job = jsonRes['job'];
    name = jsonRes['name'];
    profilePath = jsonRes['profile_path'];
  }

  @override
  String toString() {
    return '{"gender": $gender,"id": $id,"credit_id": ${creditId != null?'${json.encode(creditId)}':'null'},"department": ${department != null?'${json.encode(department)}':'null'},"job": ${job != null?'${json.encode(job)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'},"profile_path": ${profilePath != null?'${json.encode(profilePath)}':'null'}}';
  }
}

class CastData {

  int id;
  int voteCount;
  double popularity;
  double voteAverage;
  bool adult;
  bool video;
  String profilePath;
  String backdropPath;
  String character;
  String creditId;
  String originalLanguage;
  String originalTitle;
  String overview;
  String posterPath;
  String releaseDate;
  String title;
  String name;
  List<int> genreIds;

  CastData.fromParams({this.id, this.voteCount, this.name,this.profilePath,this.popularity, this.voteAverage, this.adult, this.video, this.backdropPath, this.character, this.creditId, this.originalLanguage, this.originalTitle, this.overview, this.posterPath, this.releaseDate, this.title, this.genreIds});
  
  CastData.fromJson(jsonRes) {
    id = jsonRes['id'];
    voteCount = jsonRes['vote_count'];
    popularity = double.parse(jsonRes['popularity']?.toString()??'0');
    voteAverage =double.parse(jsonRes['vote_average']?.toString()??'0') ;
    adult = jsonRes['adult'];
    video = jsonRes['video'];
    name = jsonRes['name'];
    backdropPath = jsonRes['backdrop_path'];
    character = jsonRes['character'];
    creditId = jsonRes['credit_id'];
    originalLanguage = jsonRes['original_language'];
    originalTitle = jsonRes['original_title'];
    overview = jsonRes['overview'];
    posterPath = jsonRes['poster_path'];
    releaseDate = jsonRes['release_date'];
    title = jsonRes['title'];
    profilePath=jsonRes['profile_path'];
    genreIds = jsonRes['genre_ids'] == null ? null : [];

    for (var genre_idsItem in genreIds == null ? [] : jsonRes['genre_ids']){
            genreIds.add(genre_idsItem);
    }
  }

  @override
  String toString() {
    return '{"id": $id,"vote_count": $voteCount,"profile_path":$profilePath,"name":$name,"popularity": $popularity,"vote_average": $voteAverage,"adult": $adult,"video": $video,"backdrop_path": ${backdropPath != null?'${json.encode(backdropPath)}':'null'},"character": ${character != null?'${json.encode(character)}':'null'},"credit_id": ${creditId != null?'${json.encode(creditId)}':'null'},"original_language": ${originalLanguage != null?'${json.encode(originalLanguage)}':'null'},"original_title": ${originalTitle != null?'${json.encode(originalTitle)}':'null'},"overview": ${overview != null?'${json.encode(overview)}':'null'},"poster_path": ${posterPath != null?'${json.encode(posterPath)}':'null'},"release_date": ${releaseDate != null?'${json.encode(releaseDate)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'},"genre_ids": $genreIds}';
  }
}

