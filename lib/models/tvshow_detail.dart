import 'dart:convert' show json;

import 'package:movie/models/external_ids_model.dart';
import 'package:movie/models/production_companie.dart';
import 'package:movie/models/season_detail.dart';

import 'credits_model.dart';
import 'image_model.dart';
import 'keyword.dart';
import 'review.dart';
import 'video_list.dart';

class TVDetailModel {
  int id;
  int numberOfEpisodes;
  int numberOfSeasons;
  double voteAverage;
  int voteCount;
  double popularity;
  bool inProduction;
  String backdropPath;
  String firstAirDate;
  String homepage;
  String lastAirDate;
  String name;
  String originalLanguage;
  String originalName;
  String overview;
  String posterPath;
  String status;
  String type;
  List<CreatedBy> createdBy;
  List<int> episodeRunTime;
  List<Genre> genres;
  List<String> languages;
  List<NetWork> networks;
  List<String> originCountry;
  List<ProductionCompanie> productionCompanies;
  List<Season> seasons;
  AirData lastEpisodeToAir;
  AirData nextEpisodeToAir;
  CreditsModel credits;
  ImageModel images;
  KeyWordModel keywords;
  VideoListModel recommendations;
  ReviewModel reviews;
  ExternalIdsModel externalIds;
  ContentRatingModel contentRatings;

  TVDetailModel.fromParams(
      {this.id,
      this.numberOfEpisodes,
      this.numberOfSeasons,
      this.voteAverage,
      this.voteCount,
      this.popularity,
      this.inProduction,
      this.backdropPath,
      this.firstAirDate,
      this.homepage,
      this.lastAirDate,
      this.name,
      this.originalLanguage,
      this.originalName,
      this.overview,
      this.posterPath,
      this.status,
      this.type,
      this.createdBy,
      this.episodeRunTime,
      this.genres,
      this.languages,
      this.networks,
      this.originCountry,
      this.productionCompanies,
      this.seasons,
      this.lastEpisodeToAir,
      this.nextEpisodeToAir,
      this.credits,
      this.images,
      this.keywords,
      this.recommendations,
      this.reviews,
      this.externalIds,
      this.contentRatings});

  factory TVDetailModel(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new TVDetailModel.fromJson(json.decode(jsonStr))
          : new TVDetailModel.fromJson(jsonStr);

  TVDetailModel.fromJson(jsonRes) {
    id = jsonRes['id'];
    numberOfEpisodes = jsonRes['number_of_episodes'];
    numberOfSeasons = jsonRes['number_of_seasons'];
    voteAverage = double.parse(jsonRes['vote_average'].toString());
    voteCount = jsonRes['vote_count'];
    popularity = double.parse(jsonRes['popularity'].toString());
    inProduction = jsonRes['in_production'];
    backdropPath = jsonRes['backdrop_path'];
    firstAirDate = jsonRes['first_air_date'];
    homepage = jsonRes['homepage'];
    lastAirDate = jsonRes['last_air_date'];
    name = jsonRes['name'];
    originalLanguage = jsonRes['original_language'];
    originalName = jsonRes['original_name'];
    overview = jsonRes['overview'];
    posterPath = jsonRes['poster_path'];
    status = jsonRes['status'];
    type = jsonRes['type'];
    createdBy = jsonRes['created_by'] == null ? null : [];

    for (var created_byItem in createdBy == null ? [] : jsonRes['created_by']) {
      createdBy.add(created_byItem == null
          ? null
          : new CreatedBy.fromJson(created_byItem));
    }

    episodeRunTime = jsonRes['episode_run_time'] == null ? null : [];

    for (var episode_run_timeItem
        in episodeRunTime == null ? [] : jsonRes['episode_run_time']) {
      episodeRunTime.add(episode_run_timeItem);
    }

    genres = jsonRes['genres'] == null ? null : [];

    for (var genresItem in genres == null ? [] : jsonRes['genres']) {
      genres.add(genresItem == null ? null : new Genre.fromJson(genresItem));
    }

    languages = jsonRes['languages'] == null ? null : [];

    for (var languagesItem in languages == null ? [] : jsonRes['languages']) {
      languages.add(languagesItem);
    }

    networks = jsonRes['networks'] == null ? null : [];

    for (var networksItem in networks == null ? [] : jsonRes['networks']) {
      networks.add(
          networksItem == null ? null : new NetWork.fromJson(networksItem));
    }

    originCountry = jsonRes['origin_country'] == null ? null : [];

    for (var origin_countryItem
        in originCountry == null ? [] : jsonRes['origin_country']) {
      originCountry.add(origin_countryItem);
    }

    productionCompanies = jsonRes['production_companies'] == null ? null : [];

    for (var production_companiesItem
        in productionCompanies == null ? [] : jsonRes['production_companies']) {
      productionCompanies.add(production_companiesItem == null
          ? null
          : new ProductionCompanie.fromJson(production_companiesItem));
    }

    seasons = jsonRes['seasons'] == null ? null : [];

    for (var seasonsItem in seasons == null ? [] : jsonRes['seasons']) {
      seasons
          .add(seasonsItem == null ? null : new Season.fromJson(seasonsItem));
    }

    lastEpisodeToAir = jsonRes['last_episode_to_air'] == null
        ? null
        : new AirData.fromJson(jsonRes['last_episode_to_air']);
    nextEpisodeToAir = jsonRes['next_episode_to_air'] == null
        ? null
        : new AirData.fromJson(jsonRes['next_episode_to_air']);
    credits = jsonRes['credits'] == null
        ? null
        : new CreditsModel.fromJson(jsonRes['credits']);
    images = jsonRes['images'] == null
        ? null
        : new ImageModel.fromJson(jsonRes['images']);
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
    contentRatings = jsonRes['content_ratings'] == null
        ? null
        : new ContentRatingModel.fromJson(jsonRes['content_ratings']);
  }

  @override
  String toString() {
    return '{"id": $id,"number_of_episodes": $numberOfEpisodes,"number_of_seasons": $numberOfSeasons,"vote_average": $voteAverage,"vote_count": $voteCount,"popularity": $popularity,"in_production": $inProduction,"backdrop_path": ${backdropPath != null ? '${json.encode(backdropPath)}' : 'null'},"first_air_date": ${firstAirDate != null ? '${json.encode(firstAirDate)}' : 'null'},"homepage": ${homepage != null ? '${json.encode(homepage)}' : 'null'},"last_air_date": ${lastAirDate != null ? '${json.encode(lastAirDate)}' : 'null'},"name": ${name != null ? '${json.encode(name)}' : 'null'},"original_language": ${originalLanguage != null ? '${json.encode(originalLanguage)}' : 'null'},"original_name": ${originalName != null ? '${json.encode(originalName)}' : 'null'},"overview": ${overview != null ? '${json.encode(overview)}' : 'null'},"poster_path": ${posterPath != null ? '${json.encode(posterPath)}' : 'null'},"status": ${status != null ? '${json.encode(status)}' : 'null'},"type": ${type != null ? '${json.encode(type)}' : 'null'},"created_by": $createdBy,"episode_run_time": $episodeRunTime,"genres": $genres,"languages": $languages,"networks": $networks,"origin_country": $originCountry,"production_companies": $productionCompanies,"seasons": $seasons,"last_episode_to_air": $lastEpisodeToAir,"next_episode_to_air": $nextEpisodeToAir,"credits": $credits,"images": $images,"keywords": $keywords,"recommendations": $recommendations,"reviews": $reviews,"externalids":$externalIds,"contentRatings":$contentRatings}';
  }
}

class AirData {
  Object stillPath;
  int episodeNumber;
  int id;
  int seasonNumber;
  int showId;
  double voteAverage;
  int voteCount;
  String airDate;
  String name;
  String overview;
  String productionCode;

  AirData.fromParams(
      {this.stillPath,
      this.episodeNumber,
      this.id,
      this.seasonNumber,
      this.showId,
      this.voteAverage,
      this.voteCount,
      this.airDate,
      this.name,
      this.overview,
      this.productionCode});

  AirData.fromJson(jsonRes) {
    stillPath = jsonRes['still_path'];
    episodeNumber = jsonRes['episode_number'];
    id = jsonRes['id'];
    seasonNumber = jsonRes['season_number'];
    showId = jsonRes['show_id'];
    voteAverage = double.parse(jsonRes['vote_average'].toString());
    voteCount = jsonRes['vote_count'];
    airDate = jsonRes['air_date'];
    name = jsonRes['name'];
    overview = jsonRes['overview'];
    productionCode = jsonRes['production_code'];
  }

  get profilePath => null;

  @override
  String toString() {
    return '{"still_path": $stillPath,"episode_number": $episodeNumber,"id": $id,"season_number": $seasonNumber,"show_id": $showId,"vote_average": $voteAverage,"vote_count": $voteCount,"air_date": ${airDate != null ? '${json.encode(airDate)}' : 'null'},"name": ${name != null ? '${json.encode(name)}' : 'null'},"overview": ${overview != null ? '${json.encode(overview)}' : 'null'},"production_code": ${productionCode != null ? '${json.encode(productionCode)}' : 'null'}}';
  }
}

class NetWork {
  int id;
  String logoPath;
  String name;
  String originCountry;

  NetWork.fromParams({this.id, this.logoPath, this.name, this.originCountry});

  NetWork.fromJson(jsonRes) {
    id = jsonRes['id'];
    logoPath = jsonRes['logo_path'];
    name = jsonRes['name'];
    originCountry = jsonRes['origin_country'];
  }

  @override
  String toString() {
    return '{"id": $id,"logo_path": ${logoPath != null ? '${json.encode(logoPath)}' : 'null'},"name": ${name != null ? '${json.encode(name)}' : 'null'},"origin_country": ${originCountry != null ? '${json.encode(originCountry)}' : 'null'}}';
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

class CreatedBy {
  Object profilePath;
  int gender;
  int id;
  String creditId;
  String name;

  CreatedBy.fromParams(
      {this.profilePath, this.gender, this.id, this.creditId, this.name});

  CreatedBy.fromJson(jsonRes) {
    profilePath = jsonRes['profile_path'];
    gender = jsonRes['gender'];
    id = jsonRes['id'];
    creditId = jsonRes['credit_id'];
    name = jsonRes['name'];
  }

  @override
  String toString() {
    return '{"profile_path": $profilePath,"gender": $gender,"id": $id,"credit_id": ${creditId != null ? '${json.encode(creditId)}' : 'null'},"name": ${name != null ? '${json.encode(name)}' : 'null'}}';
  }
}

class ContentRatingModel {
  int id;
  List<ContentRatingResult> results;

  ContentRatingModel.fromParams({this.id, this.results});

  factory ContentRatingModel(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new ContentRatingModel.fromJson(json.decode(jsonStr))
          : new ContentRatingModel.fromJson(jsonStr);

  ContentRatingModel.fromJson(jsonRes) {
    id = jsonRes['id'];
    results = jsonRes['results'] == null ? null : [];

    for (var resultsItem in results == null ? [] : jsonRes['results']) {
      results.add(resultsItem == null
          ? null
          : new ContentRatingResult.fromJson(resultsItem));
    }
  }

  @override
  String toString() {
    return '{"id": $id,"results": $results}';
  }
}

class ContentRatingResult {
  String iso31661;
  String rating;

  ContentRatingResult.fromParams({this.iso31661, this.rating});

  ContentRatingResult.fromJson(jsonRes) {
    iso31661 = jsonRes['iso_3166_1'];
    rating = jsonRes['rating'];
  }

  @override
  String toString() {
    return '{"iso_3166_1": ${iso31661 != null ? '${json.encode(iso31661)}' : 'null'},"rating": ${rating != null ? '${json.encode(rating)}' : 'null'}}';
  }
}
