import 'dart:convert' show json;

import 'package:movie/models/releasedatemodel.dart';
import 'package:movie/models/review.dart';
import 'package:movie/models/videolist.dart';
import 'package:movie/models/videomodel.dart';

import 'creditsmodel.dart';
import 'externalidsmodel.dart';
import 'imagemodel.dart';
import 'keyword.dart';

class MovieDetailModel {
  Object homepage;
  int budget;
  int id;
  int revenue;
  int runtime;
  int vote_count;
  double popularity;
  double vote_average;
  bool adult;
  bool video;
  String backdrop_path;
  String imdb_id;
  String original_language;
  String original_title;
  String overview;
  String poster_path;
  String release_date;
  String status;
  String tagline;
  String title;
  List<Genre> genres;
  List<ProductionCompanie> production_companies;
  List<ProductionCountrie> production_countries;
  List<SpokenLanguage> spoken_languages;
  BelongsToCollection belongs_to_collection;
  CreditsModel credits;
  ImageModel images;
  VideoModel videos;
  KeyWordModel keywords;
  VideoListModel recommendations;
  ReviewModel reviews;
  ExternalIdsModel externalids;
  ReleaseDateModel releaseDates;

  MovieDetailModel.fromParams(
      {this.homepage,
      this.budget,
      this.id,
      this.revenue,
      this.runtime,
      this.vote_count,
      this.popularity,
      this.vote_average,
      this.adult,
      this.video,
      this.backdrop_path,
      this.imdb_id,
      this.original_language,
      this.original_title,
      this.overview,
      this.poster_path,
      this.release_date,
      this.status,
      this.tagline,
      this.title,
      this.genres,
      this.production_companies,
      this.production_countries,
      this.spoken_languages,
      this.belongs_to_collection,
      this.credits,
      this.images,
      this.keywords,
      this.recommendations,
      this.reviews,
      this.externalids,
      this.releaseDates,
      this.videos});

  factory MovieDetailModel(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new MovieDetailModel.fromJson(json.decode(jsonStr))
          : new MovieDetailModel.fromJson(jsonStr);

  MovieDetailModel.fromJson(jsonRes) {
    homepage = jsonRes['homepage'];
    budget = jsonRes['budget'];
    id = jsonRes['id'];
    revenue = jsonRes['revenue'];
    runtime = jsonRes['runtime'];
    vote_count = jsonRes['vote_count'];
    popularity = jsonRes['popularity'];
    vote_average = jsonRes['vote_average'];
    adult = jsonRes['adult'];
    video = jsonRes['video'];
    backdrop_path = jsonRes['backdrop_path'];
    imdb_id = jsonRes['imdb_id'];
    original_language = jsonRes['original_language'];
    original_title = jsonRes['original_title'];
    overview = jsonRes['overview'];
    poster_path = jsonRes['poster_path'];
    release_date = jsonRes['release_date'];
    status = jsonRes['status'];
    tagline = jsonRes['tagline'];
    title = jsonRes['title'];
    genres = jsonRes['genres'] == null ? null : [];

    for (var genresItem in genres == null ? [] : jsonRes['genres']) {
      genres.add(genresItem == null ? null : new Genre.fromJson(genresItem));
    }

    production_companies = jsonRes['production_companies'] == null ? null : [];

    for (var production_companiesItem in production_companies == null
        ? []
        : jsonRes['production_companies']) {
      production_companies.add(production_companiesItem == null
          ? null
          : new ProductionCompanie.fromJson(production_companiesItem));
    }

    production_countries = jsonRes['production_countries'] == null ? null : [];

    for (var production_countriesItem in production_countries == null
        ? []
        : jsonRes['production_countries']) {
      production_countries.add(production_countriesItem == null
          ? null
          : new ProductionCountrie.fromJson(production_countriesItem));
    }

    spoken_languages = jsonRes['spoken_languages'] == null ? null : [];

    for (var spoken_languagesItem
        in spoken_languages == null ? [] : jsonRes['spoken_languages']) {
      spoken_languages.add(spoken_languagesItem == null
          ? null
          : new SpokenLanguage.fromJson(spoken_languagesItem));
    }

    belongs_to_collection = jsonRes['belongs_to_collection'] == null
        ? null
        : new BelongsToCollection.fromJson(jsonRes['belongs_to_collection']);
    credits = jsonRes['credits'] == null
        ? null
        : new CreditsModel.fromJson(jsonRes['credits']);
    images = jsonRes['images'] == null
        ? null
        : new ImageModel.fromJson(jsonRes['images']);
    videos = jsonRes['videos'] == null
        ? null
        : new VideoModel.fromJson(jsonRes['videos']);
    keywords = jsonRes['keywords'] == null
        ? null
        : new KeyWordModel.fromJson(jsonRes['keywords']);
    recommendations = jsonRes['recommendations'] == null
        ? null
        : new VideoListModel.fromJson(jsonRes['recommendations']);
    reviews = jsonRes['reviews'] == null
        ? null
        : new ReviewModel.fromJson(jsonRes['reviews']);
    externalids = jsonRes['external_ids'] == null
        ? null
        : new ExternalIdsModel.fromJson(jsonRes['external_ids']);
    releaseDates = jsonRes['release_dates'] == null
        ? null
        : new ReleaseDateModel.fromJson(jsonRes['release_dates']);
  }

  @override
  String toString() {
    return '{"homepage": $homepage,"budget": $budget,"id": $id,"revenue": $revenue,"runtime": $runtime,"vote_count": $vote_count,"popularity": $popularity,"vote_average": $vote_average,"adult": $adult,"video": $video,"backdrop_path": ${backdrop_path != null ? '${json.encode(backdrop_path)}' : 'null'},"imdb_id": ${imdb_id != null ? '${json.encode(imdb_id)}' : 'null'},"original_language": ${original_language != null ? '${json.encode(original_language)}' : 'null'},"original_title": ${original_title != null ? '${json.encode(original_title)}' : 'null'},"overview": ${overview != null ? '${json.encode(overview)}' : 'null'},"poster_path": ${poster_path != null ? '${json.encode(poster_path)}' : 'null'},"release_date": ${release_date != null ? '${json.encode(release_date)}' : 'null'},"status": ${status != null ? '${json.encode(status)}' : 'null'},"tagline": ${tagline != null ? '${json.encode(tagline)}' : 'null'},"title": ${title != null ? '${json.encode(title)}' : 'null'},"genres": $genres,"production_companies": $production_companies,"production_countries": $production_countries,"spoken_languages": $spoken_languages,"belongs_to_collection": $belongs_to_collection,"credits": $credits,"images": $images,"keywords": $keywords,"recommendations": $recommendations,"reviews": $reviews,"externalids":$externalids,"releaseDates":$releaseDates,"videos":$videos}';
  }
}

class BelongsToCollection {
  int id;
  String backdrop_path;
  String name;
  String poster_path;

  BelongsToCollection.fromParams(
      {this.id, this.backdrop_path, this.name, this.poster_path});

  BelongsToCollection.fromJson(jsonRes) {
    id = jsonRes['id'];
    backdrop_path = jsonRes['backdrop_path'];
    name = jsonRes['name'];
    poster_path = jsonRes['poster_path'];
  }

  @override
  String toString() {
    return '{"id": $id,"backdrop_path": ${backdrop_path != null ? '${json.encode(backdrop_path)}' : 'null'},"name": ${name != null ? '${json.encode(name)}' : 'null'},"poster_path": ${poster_path != null ? '${json.encode(poster_path)}' : 'null'}}';
  }
}

class SpokenLanguage {
  String iso_639_1;
  String name;

  SpokenLanguage.fromParams({this.iso_639_1, this.name});

  SpokenLanguage.fromJson(jsonRes) {
    iso_639_1 = jsonRes['iso_639_1'];
    name = jsonRes['name'];
  }

  @override
  String toString() {
    return '{"iso_639_1": ${iso_639_1 != null ? '${json.encode(iso_639_1)}' : 'null'},"name": ${name != null ? '${json.encode(name)}' : 'null'}}';
  }
}

class ProductionCountrie {
  String iso_3166_1;
  String name;

  ProductionCountrie.fromParams({this.iso_3166_1, this.name});

  ProductionCountrie.fromJson(jsonRes) {
    iso_3166_1 = jsonRes['iso_3166_1'];
    name = jsonRes['name'];
  }

  @override
  String toString() {
    return '{"iso_3166_1": ${iso_3166_1 != null ? '${json.encode(iso_3166_1)}' : 'null'},"name": ${name != null ? '${json.encode(name)}' : 'null'}}';
  }
}

class ProductionCompanie {
  int id;
  String logo_path;
  String name;
  String origin_country;

  ProductionCompanie.fromParams(
      {this.id, this.logo_path, this.name, this.origin_country});

  ProductionCompanie.fromJson(jsonRes) {
    id = jsonRes['id'];
    logo_path = jsonRes['logo_path'];
    name = jsonRes['name'];
    origin_country = jsonRes['origin_country'];
  }

  @override
  String toString() {
    return '{"id": $id,"logo_path": ${logo_path != null ? '${json.encode(logo_path)}' : 'null'},"name": ${name != null ? '${json.encode(name)}' : 'null'},"origin_country": ${origin_country != null ? '${json.encode(origin_country)}' : 'null'}}';
  }
}

class Genre {
  int id;
  String name;

  Genre.fromParams({this.id, this.name});

  Genre.fromJson(jsonRes) {
    id = jsonRes['id'];
    name = jsonRes['name'];
  }

  @override
  String toString() {
    return '{"id": $id,"name": ${name != null ? '${json.encode(name)}' : 'null'}}';
  }
}
