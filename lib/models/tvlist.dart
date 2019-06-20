import 'dart:convert' show json;

class TVListModel {

  int page;
  int total_pages;
  int total_results;
  List<TVListResult> results;

  TVListModel.fromParams({this.page, this.total_pages, this.total_results, this.results});

  factory TVListModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? new TVListModel.fromJson(json.decode(jsonStr)) : new TVListModel.fromJson(jsonStr);
  
  TVListModel.fromJson(jsonRes) {
    page = jsonRes['page'];
    total_pages = jsonRes['total_pages'];
    total_results = jsonRes['total_results'];
    results = jsonRes['results'] == null ? null : [];

    for (var resultsItem in results == null ? [] : jsonRes['results']){
            results.add(resultsItem == null ? null : new TVListResult.fromJson(resultsItem));
    }
  }

  @override
  String toString() {
    return '{"page": $page,"total_pages": $total_pages,"total_results": $total_results,"results": $results}';
  }
}

class TVListResult {

  int id;
  Object vote_average;
  int vote_count;
  double popularity;
  String backdrop_path;
  String first_air_date;
  String name;
  String original_language;
  String original_name;
  String overview;
  String poster_path;
  List<int> genre_ids;
  List<String> origin_country;

  TVListResult.fromParams({this.id, this.vote_average, this.vote_count, this.popularity, this.backdrop_path, this.first_air_date, this.name, this.original_language, this.original_name, this.overview, this.poster_path, this.genre_ids, this.origin_country});
  
  TVListResult.fromJson(jsonRes) {
    id = jsonRes['id'];
    vote_average = jsonRes['vote_average'];
    vote_count = jsonRes['vote_count'];
    popularity = jsonRes['popularity'];
    backdrop_path = jsonRes['backdrop_path'];
    first_air_date = jsonRes['first_air_date'];
    name = jsonRes['name'];
    original_language = jsonRes['original_language'];
    original_name = jsonRes['original_name'];
    overview = jsonRes['overview'];
    poster_path = jsonRes['poster_path'];
    genre_ids = jsonRes['genre_ids'] == null ? null : [];

    for (var genre_idsItem in genre_ids == null ? [] : jsonRes['genre_ids']){
            genre_ids.add(genre_idsItem);
    }

    origin_country = jsonRes['origin_country'] == null ? null : [];

    for (var origin_countryItem in origin_country == null ? [] : jsonRes['origin_country']){
            origin_country.add(origin_countryItem);
    }
  }

  @override
  String toString() {
    return '{"id": $id,"vote_average": $vote_average,"vote_count": $vote_count,"popularity": $popularity,"backdrop_path": ${backdrop_path != null?'${json.encode(backdrop_path)}':'null'},"first_air_date": ${first_air_date != null?'${json.encode(first_air_date)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'},"original_language": ${original_language != null?'${json.encode(original_language)}':'null'},"original_name": ${original_name != null?'${json.encode(original_name)}':'null'},"overview": ${overview != null?'${json.encode(overview)}':'null'},"poster_path": ${poster_path != null?'${json.encode(poster_path)}':'null'},"genre_ids": $genre_ids,"origin_country": $origin_country}';
  }
}

