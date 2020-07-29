import 'dart:convert' show json;

class MyListModel {
  int page;
  int totalPages;
  int totalResults;
  List<MyListResult> results;

  MyListModel.fromParams(
      {this.page, this.totalPages, this.totalResults, this.results});

  factory MyListModel(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new MyListModel.fromJson(json.decode(jsonStr))
          : new MyListModel.fromJson(jsonStr);

  MyListModel.fromJson(jsonRes) {
    page = jsonRes['page'];
    totalPages = jsonRes['total_pages'];
    totalResults = jsonRes['total_results'];
    results = jsonRes['results'] == null ? null : [];

    for (var resultsItem in results == null ? [] : jsonRes['results']) {
      results.add(
          resultsItem == null ? null : new MyListResult.fromJson(resultsItem));
    }
  }

  @override
  String toString() {
    return '{"page": $page,"total_pages": $totalPages,"total_results": $totalResults,"results": $results}';
  }
}

class MyListResult {
  int adult;
  int featured;
  int id;
  int numberOfItems;
  int public;
  int runtime;
  int sortBy;
  double averageRating;
  String backdropPath;
  String createdAt;
  String description;
  String iso31661;
  String iso6391;
  String name;
  String posterPath;
  String revenue;
  String updatedAt;
  bool selected;

  MyListResult.fromParams(
      {this.adult,
      this.featured,
      this.id,
      this.numberOfItems,
      this.public,
      this.runtime,
      this.sortBy,
      this.averageRating,
      this.backdropPath,
      this.createdAt,
      this.description,
      this.iso31661,
      this.iso6391,
      this.name,
      this.posterPath,
      this.revenue,
      this.updatedAt,
      this.selected});

  MyListResult.fromJson(jsonRes) {
    adult = jsonRes['adult'];
    featured = jsonRes['featured'];
    id = jsonRes['id'];
    numberOfItems = jsonRes['number_of_items'];
    public = jsonRes['public'];
    runtime = jsonRes['runtime'];
    sortBy = jsonRes['sort_by'];
    averageRating = double.parse(jsonRes['average_rating'].toString() ?? '0.0');
    backdropPath = jsonRes['backdrop_path'];
    createdAt = jsonRes['created_at'];
    description = jsonRes['description'];
    iso31661 = jsonRes['iso_3166_1'];
    iso6391 = jsonRes['iso_639_1'];
    name = jsonRes['name'];
    posterPath = jsonRes['poster_path'];
    revenue = jsonRes['revenue'];
    updatedAt = jsonRes['updated_at'];
    selected = false;
  }

  @override
  String toString() {
    return '{"adult": $adult,"featured": $featured,"id": $id,"number_of_items": $numberOfItems,"public": $public,"runtime": $runtime,"sort_by": $sortBy,"average_rating": $averageRating,"backdrop_path": ${backdropPath != null ? '${json.encode(backdropPath)}' : 'null'},"created_at": ${createdAt != null ? '${json.encode(createdAt)}' : 'null'},"description": ${description != null ? '${json.encode(description)}' : 'null'},"iso_3166_1": ${iso31661 != null ? '${json.encode(iso31661)}' : 'null'},"iso_639_1": ${iso6391 != null ? '${json.encode(iso6391)}' : 'null'},"name": ${name != null ? '${json.encode(name)}' : 'null'},"poster_path": ${posterPath != null ? '${json.encode(posterPath)}' : 'null'},"revenue": ${revenue != null ? '${json.encode(revenue)}' : 'null'},"updated_at": ${updatedAt != null ? '${json.encode(updatedAt)}' : 'null'},"selected":$selected}';
  }
}
