import 'dart:convert' show json;

class MoiveListModel {

  int page;
  int total_pages;
  int total_results;
  List<MovieListResult> results;
  DateString dates;

  MoiveListModel.fromParams({this.page, this.total_pages, this.total_results, this.results, this.dates});

  factory MoiveListModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? new MoiveListModel.fromJson(json.decode(jsonStr)) : new MoiveListModel.fromJson(jsonStr);
  
  MoiveListModel.fromJson(jsonRes) {
    page = jsonRes['page'];
    total_pages = jsonRes['total_pages'];
    total_results = jsonRes['total_results'];
    results = jsonRes['results'] == null ? null : [];

    for (var resultsItem in results == null ? [] : jsonRes['results']){
            results.add(resultsItem == null ? null : new MovieListResult.fromJson(resultsItem));
    }

    dates = jsonRes['dates'] == null ? null : new DateString.fromJson(jsonRes['dates']);
  }

  @override
  String toString() {
    return '{"page": $page,"total_pages": $total_pages,"total_results": $total_results,"results": $results,"dates": $dates}';
  }
}

class DateString {

  String maximum;
  String minimum;

  DateString.fromParams({this.maximum, this.minimum});
  
  DateString.fromJson(jsonRes) {
    maximum = jsonRes['maximum'];
    minimum = jsonRes['minimum'];
  }

  @override
  String toString() {
    return '{"maximum": ${maximum != null?'${json.encode(maximum)}':'null'},"minimum": ${minimum != null?'${json.encode(minimum)}':'null'}}';
  }
}

class MovieListResult {

  int id;
  int vote_count;
  double popularity;
  Object vote_average;
  bool adult;
  bool video;
  String backdrop_path;
  String original_language;
  String original_title;
  String overview;
  String poster_path;
  String release_date;
  String title;
  List<int> genre_ids;

  MovieListResult.fromParams({this.id, this.vote_count, this.popularity, this.vote_average, this.adult, this.video, this.backdrop_path, this.original_language, this.original_title, this.overview, this.poster_path, this.release_date, this.title, this.genre_ids});
  
  MovieListResult.fromJson(jsonRes) {
    id = jsonRes['id'];
    vote_count = jsonRes['vote_count'];
    popularity = jsonRes['popularity'];
    vote_average = jsonRes['vote_average'];
    adult = jsonRes['adult'];
    video = jsonRes['video'];
    backdrop_path = jsonRes['backdrop_path'];
    original_language = jsonRes['original_language'];
    original_title = jsonRes['original_title'];
    overview = jsonRes['overview'];
    poster_path = jsonRes['poster_path'];
    release_date = jsonRes['release_date'];
    title = jsonRes['title'];
    genre_ids = jsonRes['genre_ids'] == null ? null : [];

    for (var genre_idsItem in genre_ids == null ? [] : jsonRes['genre_ids']){
            genre_ids.add(genre_idsItem);
    }
  }

  @override
  String toString() {
    return '{"id": $id,"vote_count": $vote_count,"popularity": $popularity,"vote_average": $vote_average,"adult": $adult,"video": $video,"backdrop_path": ${backdrop_path != null?'${json.encode(backdrop_path)}':'null'},"original_language": ${original_language != null?'${json.encode(original_language)}':'null'},"original_title": ${original_title != null?'${json.encode(original_title)}':'null'},"overview": ${overview != null?'${json.encode(overview)}':'null'},"poster_path": ${poster_path != null?'${json.encode(poster_path)}':'null'},"release_date": ${release_date != null?'${json.encode(release_date)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'},"genre_ids": $genre_ids}';
  }
}

