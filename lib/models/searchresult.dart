import 'dart:convert' show json;

class SearchResultModel {

  int page;
  int total_pages;
  int total_results;
  List<SearchResult> results;

  SearchResultModel.fromParams({this.page, this.total_pages, this.total_results, this.results});

  factory SearchResultModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? new SearchResultModel.fromJson(json.decode(jsonStr)) : new SearchResultModel.fromJson(jsonStr);
  
  SearchResultModel.fromJson(jsonRes) {
    page = jsonRes['page'];
    total_pages = jsonRes['total_pages'];
    total_results = jsonRes['total_results'];
    results = jsonRes['results'] == null ? null : [];

    for (var resultsItem in results == null ? [] : jsonRes['results']){
            results.add(resultsItem == null ? null : new SearchResult.fromJson(resultsItem));
    }
  }

  @override
  String toString() {
    return '{"page": $page,"total_pages": $total_pages,"total_results": $total_results,"results": $results}';
  }
}

class SearchResult {

  Object backdrop_path;
  Object poster_path;
  int id;
  int popularity;
  int vote_average;
  int vote_count;
  String first_air_date;
  String media_type;
  String name;
  String original_language;
  String original_name;
  String overview;
  List<dynamic> genre_ids;
  List<String> origin_country;

  SearchResult.fromParams({this.backdrop_path, this.poster_path, this.id, this.popularity, this.vote_average, this.vote_count, this.first_air_date, this.media_type, this.name, this.original_language, this.original_name, this.overview, this.genre_ids, this.origin_country});
  
  SearchResult.fromJson(jsonRes) {
    backdrop_path = jsonRes['backdrop_path'];
    poster_path = jsonRes['poster_path'];
    id = jsonRes['id'];
    popularity = jsonRes['popularity'];
    vote_average = jsonRes['vote_average'];
    vote_count = jsonRes['vote_count'];
    first_air_date = jsonRes['first_air_date'];
    media_type = jsonRes['media_type'];
    name = jsonRes['name'];
    original_language = jsonRes['original_language'];
    original_name = jsonRes['original_name'];
    overview = jsonRes['overview'];
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
    return '{"backdrop_path": $backdrop_path,"poster_path": $poster_path,"id": $id,"popularity": $popularity,"vote_average": $vote_average,"vote_count": $vote_count,"first_air_date": ${first_air_date != null?'${json.encode(first_air_date)}':'null'},"media_type": ${media_type != null?'${json.encode(media_type)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'},"original_language": ${original_language != null?'${json.encode(original_language)}':'null'},"original_name": ${original_name != null?'${json.encode(original_name)}':'null'},"overview": ${overview != null?'${json.encode(overview)}':'null'},"genre_ids": $genre_ids,"origin_country": $origin_country}';
  }
}

