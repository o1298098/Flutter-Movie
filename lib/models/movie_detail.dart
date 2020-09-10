import 'dart:convert' show json;

import 'package:movie/models/production_companie.dart';
import 'package:movie/models/release_date_model.dart';
import 'package:movie/models/review.dart';
import 'package:movie/models/video_list.dart';
import 'package:movie/models/video_model.dart';

import 'credits_model.dart';
import 'external_ids_model.dart';
import 'genre.dart';
import 'image_model.dart';
import 'keyword.dart';

class MovieDetailModel {
  Object homepage;
  int budget;
  int id;
  int revenue;
  int runtime;
  int voteCount;
  double popularity;
  double voteAverage;
  bool adult;
  bool video;
  String backdropPath;
  String imdbId;
  String originalLanguage;
  String originalTitle;
  String overview;
  String posterPath;
  String releaseDate;
  String status;
  String tagLine;
  String title;
  List<Genre> genres;
  List<ProductionCompanie> productionCompanies;
  List<ProductionCountrie> productionCountries;
  List<SpokenLanguage> spokenLanguages;
  BelongsToCollection belongsToCollection;
  CreditsModel credits;
  ImageModel images;
  VideoModel videos;
  KeyWordModel keywords;
  VideoListModel recommendations;
  ReviewModel reviews;
  ExternalIdsModel externalIds;
  ReleaseDateModel releaseDates;

  MovieDetailModel.fromParams(
      {this.homepage,
      this.budget,
      this.id,
      this.revenue,
      this.runtime,
      this.voteCount,
      this.popularity,
      this.voteAverage,
      this.adult,
      this.video,
      this.backdropPath,
      this.imdbId,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.posterPath,
      this.releaseDate,
      this.status,
      this.tagLine,
      this.title,
      this.genres,
      this.productionCompanies,
      this.productionCountries,
      this.spokenLanguages,
      this.belongsToCollection,
      this.credits,
      this.images,
      this.keywords,
      this.recommendations,
      this.reviews,
      this.externalIds,
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
    voteCount = jsonRes['vote_count'];
    popularity = jsonRes['popularity'];
    voteAverage = jsonRes['vote_average'];
    adult = jsonRes['adult'];
    video = jsonRes['video'];
    backdropPath = jsonRes['backdrop_path'];
    imdbId = jsonRes['imdb_id'];
    originalLanguage = jsonRes['original_language'];
    originalTitle = jsonRes['original_title'];
    overview = jsonRes['overview'];
    posterPath = jsonRes['poster_path'];
    releaseDate = jsonRes['release_date'];
    status = jsonRes['status'];
    tagLine = jsonRes['tagline'];
    title = jsonRes['title'];
    genres = jsonRes['genres'] == null ? null : [];

    for (var genresItem in genres == null ? [] : jsonRes['genres']) {
      genres.add(genresItem == null ? null : new Genre.fromJson(genresItem));
    }

    productionCompanies = jsonRes['production_companies'] == null ? null : [];

    for (var production_companiesItem
        in productionCompanies == null ? [] : jsonRes['production_companies']) {
      productionCompanies.add(production_companiesItem == null
          ? null
          : new ProductionCompanie.fromJson(production_companiesItem));
    }

    productionCountries = jsonRes['production_countries'] == null ? null : [];

    for (var production_countriesItem
        in productionCountries == null ? [] : jsonRes['production_countries']) {
      productionCountries.add(production_countriesItem == null
          ? null
          : new ProductionCountrie.fromJson(production_countriesItem));
    }

    spokenLanguages = jsonRes['spoken_languages'] == null ? null : [];

    for (var spoken_languagesItem
        in spokenLanguages == null ? [] : jsonRes['spoken_languages']) {
      spokenLanguages.add(spoken_languagesItem == null
          ? null
          : new SpokenLanguage.fromJson(spoken_languagesItem));
    }

    belongsToCollection = jsonRes['belongs_to_collection'] == null
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
    externalIds = jsonRes['external_ids'] == null
        ? null
        : new ExternalIdsModel.fromJson(jsonRes['external_ids']);
    releaseDates = jsonRes['release_dates'] == null
        ? null
        : new ReleaseDateModel.fromJson(jsonRes['release_dates']);
  }

  @override
  String toString() {
    return '{"homepage": $homepage,"budget": $budget,"id": $id,"revenue": $revenue,"runtime": $runtime,"vote_count": $voteCount,"popularity": $popularity,"vote_average": $voteAverage,"adult": $adult,"video": $video,"backdrop_path": ${backdropPath != null ? '${json.encode(backdropPath)}' : 'null'},"imdb_id": ${imdbId != null ? '${json.encode(imdbId)}' : 'null'},"original_language": ${originalLanguage != null ? '${json.encode(originalLanguage)}' : 'null'},"original_title": ${originalTitle != null ? '${json.encode(originalTitle)}' : 'null'},"overview": ${overview != null ? '${json.encode(overview)}' : 'null'},"poster_path": ${posterPath != null ? '${json.encode(posterPath)}' : 'null'},"release_date": ${releaseDate != null ? '${json.encode(releaseDate)}' : 'null'},"status": ${status != null ? '${json.encode(status)}' : 'null'},"tagline": ${tagLine != null ? '${json.encode(tagLine)}' : 'null'},"title": ${title != null ? '${json.encode(title)}' : 'null'},"genres": $genres,"production_companies": $productionCompanies,"production_countries": $productionCountries,"spoken_languages": $spokenLanguages,"belongs_to_collection": $belongsToCollection,"credits": $credits,"images": $images,"keywords": $keywords,"recommendations": $recommendations,"reviews": $reviews,"externalids":$externalIds,"releaseDates":$releaseDates,"videos":$videos}';
  }
}

class BelongsToCollection {
  int id;
  String backdropPath;
  String name;
  String posterPath;

  BelongsToCollection.fromParams(
      {this.id, this.backdropPath, this.name, this.posterPath});

  BelongsToCollection.fromJson(jsonRes) {
    id = jsonRes['id'];
    backdropPath = jsonRes['backdrop_path'];
    name = jsonRes['name'];
    posterPath = jsonRes['poster_path'];
  }

  @override
  String toString() {
    return '{"id": $id,"backdrop_path": ${backdropPath != null ? '${json.encode(backdropPath)}' : 'null'},"name": ${name != null ? '${json.encode(name)}' : 'null'},"poster_path": ${posterPath != null ? '${json.encode(posterPath)}' : 'null'}}';
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
