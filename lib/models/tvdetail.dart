import 'dart:convert' show json;

import 'package:movie/models/externalidsmodel.dart';

import 'creditsmodel.dart';
import 'episodemodel.dart';
import 'imagemodel.dart';
import 'keyword.dart';
import 'review.dart';
import 'videolist.dart';

class TVDetailModel {
  int id;
  int number_of_episodes;
  int number_of_seasons;
  double vote_average;
  int vote_count;
  double popularity;
  bool in_production;
  String backdrop_path;
  String first_air_date;
  String homepage;
  String last_air_date;
  String name;
  String original_language;
  String original_name;
  String overview;
  String poster_path;
  String status;
  String type;
  List<CreatedBy> created_by;
  List<int> episode_run_time;
  List<Genre> genres;
  List<String> languages;
  List<NetWork> networks;
  List<String> origin_country;
  List<ProductionCompanie> production_companies;
  List<Season> seasons;
  AirData last_episode_to_air;
  AirData next_episode_to_air;
  CreditsModel credits;
  ImageModel images;
  KeyWordModel keywords;
  VideoListModel recommendations;
  ReviewModel reviews;
  ExternalIdsModel externalids;
  ContentRatingModel contentRatings;

  TVDetailModel.fromParams(
      {this.id,
      this.number_of_episodes,
      this.number_of_seasons,
      this.vote_average,
      this.vote_count,
      this.popularity,
      this.in_production,
      this.backdrop_path,
      this.first_air_date,
      this.homepage,
      this.last_air_date,
      this.name,
      this.original_language,
      this.original_name,
      this.overview,
      this.poster_path,
      this.status,
      this.type,
      this.created_by,
      this.episode_run_time,
      this.genres,
      this.languages,
      this.networks,
      this.origin_country,
      this.production_companies,
      this.seasons,
      this.last_episode_to_air,
      this.next_episode_to_air,
      this.credits,
      this.images,
      this.keywords,
      this.recommendations,
      this.reviews,
      this.externalids,
      this.contentRatings});

  factory TVDetailModel(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new TVDetailModel.fromJson(json.decode(jsonStr))
          : new TVDetailModel.fromJson(jsonStr);

  TVDetailModel.fromJson(jsonRes) {
    id = jsonRes['id'];
    number_of_episodes = jsonRes['number_of_episodes'];
    number_of_seasons = jsonRes['number_of_seasons'];
    vote_average = double.parse(jsonRes['vote_average'].toString());
    vote_count = jsonRes['vote_count'];
    popularity = double.parse(jsonRes['popularity'].toString());
    in_production = jsonRes['in_production'];
    backdrop_path = jsonRes['backdrop_path'];
    first_air_date = jsonRes['first_air_date'];
    homepage = jsonRes['homepage'];
    last_air_date = jsonRes['last_air_date'];
    name = jsonRes['name'];
    original_language = jsonRes['original_language'];
    original_name = jsonRes['original_name'];
    overview = jsonRes['overview'];
    poster_path = jsonRes['poster_path'];
    status = jsonRes['status'];
    type = jsonRes['type'];
    created_by = jsonRes['created_by'] == null ? null : [];

    for (var created_byItem
        in created_by == null ? [] : jsonRes['created_by']) {
      created_by.add(created_byItem == null
          ? null
          : new CreatedBy.fromJson(created_byItem));
    }

    episode_run_time = jsonRes['episode_run_time'] == null ? null : [];

    for (var episode_run_timeItem
        in episode_run_time == null ? [] : jsonRes['episode_run_time']) {
      episode_run_time.add(episode_run_timeItem);
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

    origin_country = jsonRes['origin_country'] == null ? null : [];

    for (var origin_countryItem
        in origin_country == null ? [] : jsonRes['origin_country']) {
      origin_country.add(origin_countryItem);
    }

    production_companies = jsonRes['production_companies'] == null ? null : [];

    for (var production_companiesItem in production_companies == null
        ? []
        : jsonRes['production_companies']) {
      production_companies.add(production_companiesItem == null
          ? null
          : new ProductionCompanie.fromJson(production_companiesItem));
    }

    seasons = jsonRes['seasons'] == null ? null : [];

    for (var seasonsItem in seasons == null ? [] : jsonRes['seasons']) {
      seasons
          .add(seasonsItem == null ? null : new Season.fromJson(seasonsItem));
    }

    last_episode_to_air = jsonRes['last_episode_to_air'] == null
        ? null
        : new AirData.fromJson(jsonRes['last_episode_to_air']);
    next_episode_to_air = jsonRes['next_episode_to_air'] == null
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
    externalids = jsonRes['external_ids'] == null
        ? null
        : new ExternalIdsModel.fromJson(jsonRes['external_ids']);
    contentRatings = jsonRes['content_ratings'] == null
        ? null
        : new ContentRatingModel.fromJson(jsonRes['content_ratings']);
  }

  @override
  String toString() {
    return '{"id": $id,"number_of_episodes": $number_of_episodes,"number_of_seasons": $number_of_seasons,"vote_average": $vote_average,"vote_count": $vote_count,"popularity": $popularity,"in_production": $in_production,"backdrop_path": ${backdrop_path != null ? '${json.encode(backdrop_path)}' : 'null'},"first_air_date": ${first_air_date != null ? '${json.encode(first_air_date)}' : 'null'},"homepage": ${homepage != null ? '${json.encode(homepage)}' : 'null'},"last_air_date": ${last_air_date != null ? '${json.encode(last_air_date)}' : 'null'},"name": ${name != null ? '${json.encode(name)}' : 'null'},"original_language": ${original_language != null ? '${json.encode(original_language)}' : 'null'},"original_name": ${original_name != null ? '${json.encode(original_name)}' : 'null'},"overview": ${overview != null ? '${json.encode(overview)}' : 'null'},"poster_path": ${poster_path != null ? '${json.encode(poster_path)}' : 'null'},"status": ${status != null ? '${json.encode(status)}' : 'null'},"type": ${type != null ? '${json.encode(type)}' : 'null'},"created_by": $created_by,"episode_run_time": $episode_run_time,"genres": $genres,"languages": $languages,"networks": $networks,"origin_country": $origin_country,"production_companies": $production_companies,"seasons": $seasons,"last_episode_to_air": $last_episode_to_air,"next_episode_to_air": $next_episode_to_air,"credits": $credits,"images": $images,"keywords": $keywords,"recommendations": $recommendations,"reviews": $reviews,"externalids":$externalids,"contentRatings":$contentRatings}';
  }
}

class AirData {
  Object still_path;
  int episode_number;
  int id;
  int season_number;
  int show_id;
  double vote_average;
  int vote_count;
  String air_date;
  String name;
  String overview;
  String production_code;

  AirData.fromParams(
      {this.still_path,
      this.episode_number,
      this.id,
      this.season_number,
      this.show_id,
      this.vote_average,
      this.vote_count,
      this.air_date,
      this.name,
      this.overview,
      this.production_code});

  AirData.fromJson(jsonRes) {
    still_path = jsonRes['still_path'];
    episode_number = jsonRes['episode_number'];
    id = jsonRes['id'];
    season_number = jsonRes['season_number'];
    show_id = jsonRes['show_id'];
    vote_average = double.parse(jsonRes['vote_average'].toString());
    vote_count = jsonRes['vote_count'];
    air_date = jsonRes['air_date'];
    name = jsonRes['name'];
    overview = jsonRes['overview'];
    production_code = jsonRes['production_code'];
  }

  @override
  String toString() {
    return '{"still_path": $still_path,"episode_number": $episode_number,"id": $id,"season_number": $season_number,"show_id": $show_id,"vote_average": $vote_average,"vote_count": $vote_count,"air_date": ${air_date != null ? '${json.encode(air_date)}' : 'null'},"name": ${name != null ? '${json.encode(name)}' : 'null'},"overview": ${overview != null ? '${json.encode(overview)}' : 'null'},"production_code": ${production_code != null ? '${json.encode(production_code)}' : 'null'}}';
  }
}

class Season {
  int episode_count;
  int id;
  int season_number;
  String air_date;
  String name;
  String overview;
  String poster_path;
  List<Episode> episodes;
  CreditsModel credits;

  Season.fromParams(
      {this.episode_count,
      this.id,
      this.season_number,
      this.air_date,
      this.name,
      this.overview,
      this.poster_path,
      this.episodes,
      this.credits});

  Season.fromJson(jsonRes) {
    episode_count = jsonRes['episode_count'];
    id = jsonRes['id'];
    season_number = jsonRes['season_number'];
    air_date = jsonRes['air_date'];
    name = jsonRes['name'];
    overview = jsonRes['overview'];
    poster_path = jsonRes['poster_path'];
  }

  @override
  String toString() {
    return '{"episode_count": $episode_count,"id": $id,"season_number": $season_number,"air_date": ${air_date != null ? '${json.encode(air_date)}' : 'null'},"name": ${name != null ? '${json.encode(name)}' : 'null'},"overview": ${overview != null ? '${json.encode(overview)}' : 'null'},"poster_path": ${poster_path != null ? '${json.encode(poster_path)}' : 'null'}}';
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

class NetWork {
  int id;
  String logo_path;
  String name;
  String origin_country;

  NetWork.fromParams({this.id, this.logo_path, this.name, this.origin_country});

  NetWork.fromJson(jsonRes) {
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

class CreatedBy {
  Object profile_path;
  int gender;
  int id;
  String credit_id;
  String name;

  CreatedBy.fromParams(
      {this.profile_path, this.gender, this.id, this.credit_id, this.name});

  CreatedBy.fromJson(jsonRes) {
    profile_path = jsonRes['profile_path'];
    gender = jsonRes['gender'];
    id = jsonRes['id'];
    credit_id = jsonRes['credit_id'];
    name = jsonRes['name'];
  }

  @override
  String toString() {
    return '{"profile_path": $profile_path,"gender": $gender,"id": $id,"credit_id": ${credit_id != null ? '${json.encode(credit_id)}' : 'null'},"name": ${name != null ? '${json.encode(name)}' : 'null'}}';
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
