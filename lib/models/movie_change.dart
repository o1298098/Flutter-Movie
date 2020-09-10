import 'dart:convert' show json;

class MovieChangeModel {

  int page;
  int totalPages;
  int totalResults;
  List<ChangeResult> results;

  MovieChangeModel.fromParams({this.page, this.totalPages, this.totalResults, this.results});

  factory MovieChangeModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? new MovieChangeModel.fromJson(json.decode(jsonStr)) : new MovieChangeModel.fromJson(jsonStr);
  
  MovieChangeModel.fromJson(jsonRes) {
    page = jsonRes['page'];
    totalPages = jsonRes['total_pages'];
    totalResults = jsonRes['total_results'];
    results = jsonRes['results'] == null ? null : [];

    for (var resultsItem in results == null ? [] : jsonRes['results']){
            results.add(resultsItem == null ? null : new ChangeResult.fromJson(resultsItem));
    }
  }

  @override
  String toString() {
    return '{"page": $page,"total_pages": $totalPages,"total_results": $totalResults,"results": $results}';
  }
}

class ChangeResult {

  int id;
  bool adult;

  ChangeResult.fromParams({this.id, this.adult});
  
  ChangeResult.fromJson(jsonRes) {
    id = jsonRes['id'];
    adult = jsonRes['adult'];
  }

  @override
  String toString() {
    return '{"id": $id,"adult": $adult}';
  }
}

