import 'dart:convert' show json;

class CombinedCreditsModel {

  int id;
  List<CastData> cast;
  List<CrewData> crew;

  CombinedCreditsModel.fromParams({this.id, this.cast, this.crew});

  factory CombinedCreditsModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? new CombinedCreditsModel.fromJson(json.decode(jsonStr)) : new CombinedCreditsModel.fromJson(jsonStr);
  
  CombinedCreditsModel.fromJson(jsonRes) {
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

  CombinedCreditsModel clone()
  {
    return new CombinedCreditsModel.fromParams(id:id,cast: cast,crew: crew);
  }

  @override
  String toString() {
    return '{"id": $id,"cast": $cast,"crew": $crew}';
  }
}

class CrewData {

  int id;
  double vote_average;
  int vote_count;
  double popularity;
  bool adult;
  bool video;
  String backdrop_path;
  String credit_id;
  String department;
  String job;
  String media_type;
  String original_language;
  String original_title;
  String overview;
  String poster_path;
  String release_date;
  String title;
  List<int> genre_ids;
  int episode_count;
  String name;
  String original_name;
  String first_air_date;

  CrewData.fromParams({this.id,this.episode_count,this.name,this.original_name,this.first_air_date, this.vote_average, this.vote_count, this.popularity, this.adult, this.video, this.backdrop_path, this.credit_id, this.department, this.job, this.media_type, this.original_language, this.original_title, this.overview, this.poster_path, this.release_date, this.title, this.genre_ids});
  
  CrewData.fromJson(jsonRes) {
    id = jsonRes['id'];
    vote_average = double.parse( jsonRes['vote_average']?.toString()??'0');
    vote_count = jsonRes['vote_count'];
    popularity = jsonRes['popularity'];
    adult = jsonRes['adult'];
    video = jsonRes['video'];
    backdrop_path = jsonRes['backdrop_path'];
    credit_id = jsonRes['credit_id'];
    department = jsonRes['department'];
    job = jsonRes['job'];
    media_type = jsonRes['media_type'];
    original_language = jsonRes['original_language'];
    original_title = jsonRes['original_title'];
    overview = jsonRes['overview'];
    poster_path = jsonRes['poster_path'];
    release_date = jsonRes['release_date'];
    title = jsonRes['title'];
    genre_ids = jsonRes['genre_ids'] == null ? null : [];
    episode_count= jsonRes['episode_count'];
    name= jsonRes['name'];
    original_name= jsonRes['original_name'];
    first_air_date= jsonRes['first_air_date'];

    for (var genre_idsItem in genre_ids == null ? [] : jsonRes['genre_ids']){
            genre_ids.add(genre_idsItem);
    }
  }
  
  @override
  String toString() {
    return '{"id": $id,"first_air_date": $first_air_date,"original_name": $original_name,"name": $name,"episode_count": $episode_count,"vote_average": $vote_average,"vote_count": $vote_count,"popularity": $popularity,"adult": $adult,"video": $video,"backdrop_path": ${backdrop_path != null?'${json.encode(backdrop_path)}':'null'},"credit_id": ${credit_id != null?'${json.encode(credit_id)}':'null'},"department": ${department != null?'${json.encode(department)}':'null'},"job": ${job != null?'${json.encode(job)}':'null'},"media_type": ${media_type != null?'${json.encode(media_type)}':'null'},"original_language": ${original_language != null?'${json.encode(original_language)}':'null'},"original_title": ${original_title != null?'${json.encode(original_title)}':'null'},"overview": ${overview != null?'${json.encode(overview)}':'null'},"poster_path": ${poster_path != null?'${json.encode(poster_path)}':'null'},"release_date": ${release_date != null?'${json.encode(release_date)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'},"genre_ids": $genre_ids}';
  }
}

class CastData {

  int id;
  int vote_count;
  double popularity;
  double vote_average;
  bool adult;
  bool video;
  int episode_count;
  String backdrop_path;
  String character;
  String credit_id;
  String media_type;
  String original_language;
  String original_title;
  String overview;
  String poster_path;
  String release_date;
  String title;
  String name;
  String original_name;
  String first_air_date;
  List<int> genre_ids;

  CastData.fromParams({this.id,this.episode_count,this.name,this.original_name,this.first_air_date, this.vote_count, this.popularity, this.vote_average, this.adult, this.video, this.backdrop_path, this.character, this.credit_id, this.media_type, this.original_language, this.original_title, this.overview, this.poster_path, this.release_date, this.title, this.genre_ids});
  
  CastData.fromJson(jsonRes) {
    id = jsonRes['id'];
    vote_count = jsonRes['vote_count'];
    popularity = double.parse( jsonRes['popularity']?.toString()??'0');
    vote_average =double.parse( jsonRes['vote_average']?.toString()??'0');
    adult = jsonRes['adult'];
    video = jsonRes['video'];
    backdrop_path = jsonRes['backdrop_path'];
    character = jsonRes['character'];
    credit_id = jsonRes['credit_id'];
    media_type = jsonRes['media_type'];
    original_language = jsonRes['original_language'];
    original_title = jsonRes['original_title'];
    overview = jsonRes['overview'];
    poster_path = jsonRes['poster_path'];
    release_date = jsonRes['release_date'];
    title = jsonRes['title'];
    genre_ids = jsonRes['genre_ids'] == null ? null : [];
    episode_count= jsonRes['episode_count'];
    name= jsonRes['name'];
    original_name= jsonRes['original_name'];
    first_air_date= jsonRes['first_air_date'];

    for (var genre_idsItem in genre_ids == null ? [] : jsonRes['genre_ids']){
            genre_ids.add(genre_idsItem);
    }
  }

  @override
  String toString() {
    return '{"id": $id,"first_air_date": $first_air_date,"original_name": $original_name,"name": $name,"episode_count": $episode_count,,"vote_count": $vote_count,"popularity": $popularity,"vote_average": $vote_average,"adult": $adult,"video": $video,"backdrop_path": ${backdrop_path != null?'${json.encode(backdrop_path)}':'null'},"character": ${character != null?'${json.encode(character)}':'null'},"credit_id": ${credit_id != null?'${json.encode(credit_id)}':'null'},"media_type": ${media_type != null?'${json.encode(media_type)}':'null'},"original_language": ${original_language != null?'${json.encode(original_language)}':'null'},"original_title": ${original_title != null?'${json.encode(original_title)}':'null'},"overview": ${overview != null?'${json.encode(overview)}':'null'},"poster_path": ${poster_path != null?'${json.encode(poster_path)}':'null'},"release_date": ${release_date != null?'${json.encode(release_date)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'},"genre_ids": $genre_ids}';
  }
}

