import 'dart:convert' show json;

import 'package:movie/models/video_list.dart';

class ListDetailModel {
  int id;
  int page;
  int runtime;
  int totalPages;
  int totalResults;
  double averageRating;
  bool public;
  String backdropPath;
  String description;
  String iso31661;
  String iso6391;
  String name;
  String posterPath;
  int revenue;
  List<VideoListResult> results;
  Comments comments;
  ListCreatedBy createdBy;
  ObjectIds objectIds;

  ListDetailModel.fromParams(
      {this.id,
      this.page,
      this.runtime,
      this.totalPages,
      this.totalResults,
      this.averageRating,
      this.public,
      this.backdropPath,
      this.description,
      this.iso31661,
      this.iso6391,
      this.name,
      this.posterPath,
      this.revenue,
      this.results,
      this.comments,
      this.createdBy,
      this.objectIds});

  factory ListDetailModel(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new ListDetailModel.fromJson(json.decode(jsonStr))
          : new ListDetailModel.fromJson(jsonStr);

  ListDetailModel.fromJson(jsonRes) {
    id = jsonRes['id'];
    page = jsonRes['page'];
    runtime = jsonRes['runtime'];
    totalPages = jsonRes['total_pages'];
    totalResults = jsonRes['total_results'];
    averageRating = double.parse(jsonRes['average_rating'].toString() ?? '0.0');
    public = jsonRes['public'];
    backdropPath = jsonRes['backdrop_path'];
    description = jsonRes['description'];
    iso31661 = jsonRes['iso_3166_1'];
    iso6391 = jsonRes['iso_639_1'];
    name = jsonRes['name'];
    posterPath = jsonRes['poster_path'];
    revenue = jsonRes['revenue'];
    results = jsonRes['results'] == null ? null : [];

    for (var resultsItem in results == null ? [] : jsonRes['results']) {
      results.add(resultsItem == null
          ? null
          : new VideoListResult.fromJson(resultsItem));
    }

    //comments = jsonRes['comments'] == null ? null : new Comments.fromJson(jsonRes['comments']);
    createdBy = jsonRes['created_by'] == null
        ? null
        : new ListCreatedBy.fromJson(jsonRes['created_by']);
    //objectIds = jsonRes['object_ids'] == null ? null : new ObjectIds.fromJson(jsonRes['object_ids']);
  }

  @override
  String toString() {
    return '{"id": $id,"page": $page,"runtime": $runtime,"total_pages": $totalPages,"total_results": $totalResults,"average_rating": $averageRating,"public": $public,"backdrop_path": ${backdropPath != null ? '${json.encode(backdropPath)}' : 'null'},"description": ${description != null ? '${json.encode(description)}' : 'null'},"iso_3166_1": ${iso31661 != null ? '${json.encode(iso31661)}' : 'null'},"iso_639_1": ${iso6391 != null ? '${json.encode(iso6391)}' : 'null'},"name": ${name != null ? '${json.encode(name)}' : 'null'},"poster_path": ${posterPath != null ? '${json.encode(posterPath)}' : 'null'},"revenue": ${revenue != null ? '${json.encode(revenue)}' : 'null'},"results": $results,"comments": $comments,"created_by": $createdBy,"object_ids": $objectIds}';
  }
}

class ObjectIds {}

class ListCreatedBy {
  String gravatarHash;
  String name;
  String username;

  ListCreatedBy.fromParams({this.gravatarHash, this.name, this.username});

  ListCreatedBy.fromJson(jsonRes) {
    gravatarHash = jsonRes['gravatar_hash'];
    name = jsonRes['name'];
    username = jsonRes['username'];
  }

  @override
  String toString() {
    return '{"gravatar_hash": ${gravatarHash != null ? '${json.encode(gravatarHash)}' : 'null'},"name": ${name != null ? '${json.encode(name)}' : 'null'},"username": ${username != null ? '${json.encode(username)}' : 'null'}}';
  }
}

class Comments {}
