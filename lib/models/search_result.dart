import 'dart:convert' show json;

class SearchResultModel {
  int page;
  int totalPages;
  int totalResults;
  List<SearchResult> results;

  SearchResultModel.fromParams(
      {this.page, this.totalPages, this.totalResults, this.results});

  factory SearchResultModel(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new SearchResultModel.fromJson(json.decode(jsonStr))
          : new SearchResultModel.fromJson(jsonStr);

  SearchResultModel.fromJson(jsonRes) {
    page = jsonRes['page'];
    totalPages = jsonRes['total_pages'];
    totalResults = jsonRes['total_results'];
    results = jsonRes['results'] == null ? null : [];

    for (var resultsItem in results == null ? [] : jsonRes['results']) {
      results.add(
          resultsItem == null ? null : new SearchResult.fromJson(resultsItem));
    }
  }

  @override
  String toString() {
    return '{"page": $page,"total_pages": $totalPages,"total_results": $totalResults,"results": $results}';
  }
}

class SearchResult {
  int id;
  double voteAverage;
  int voteCount;
  double popularity;
  bool adult;
  bool video;
  String backdropPath;
  String firstAirDate;
  String mediaType;
  String name;
  String originalLanguage;
  String originalName;
  String originalTitle;
  String overview;
  String posterPath;
  String profilePath;
  String releaseDate;
  String title;
  List<int> genreIds;
  List<KnownFor> knownFor;
  List<String> originCountry;
  bool liked;

  SearchResult.fromParams(
      {this.id,
      this.voteAverage,
      this.voteCount,
      this.popularity,
      this.adult,
      this.video,
      this.backdropPath,
      this.firstAirDate,
      this.mediaType,
      this.name,
      this.originalLanguage,
      this.originalName,
      this.originalTitle,
      this.overview,
      this.posterPath,
      this.profilePath,
      this.releaseDate,
      this.title,
      this.genreIds,
      this.knownFor,
      this.originCountry});

  SearchResult.fromJson(jsonRes) {
    id = jsonRes['id'];
    popularity = double.parse(jsonRes['popularity']?.toString() ?? '0.0');
    voteAverage = double.parse(jsonRes['vote_average']?.toString() ?? '0.0');
    voteCount = jsonRes['vote_count'];
    adult = jsonRes['adult'];
    video = jsonRes['video'];
    backdropPath = jsonRes['backdrop_path'];
    firstAirDate = jsonRes['first_air_date'];
    mediaType = jsonRes['media_type'];
    name = jsonRes['name'];
    originalLanguage = jsonRes['original_language'];
    originalName = jsonRes['original_name'];
    originalTitle = jsonRes['original_title'];
    overview = jsonRes['overview'];
    posterPath = jsonRes['poster_path'];
    profilePath = jsonRes['profile_path'];
    releaseDate = jsonRes['release_date'];
    title = jsonRes['title'];
    genreIds = jsonRes['genre_ids'] == null ? null : [];

    for (var genreIdsItem in genreIds == null ? [] : jsonRes['genre_ids']) {
      genreIds.add(genreIdsItem);
    }

    knownFor = jsonRes['known_for'] == null ? null : [];

    for (var knownForItem
        in knownFor == null ? [] : [] /*jsonRes['known_for']*/) {
      knownFor.add(
          knownForItem == null ? null : new KnownFor.fromJson(knownForItem));
    }

    originCountry = jsonRes['origin_country'] == null ? null : [];

    for (var originCountryItem
        in originCountry == null ? [] : jsonRes['origin_country']) {
      originCountry.add(originCountryItem);
    }
  }

  @override
  String toString() {
    return '{"id": $id,"vote_average": $voteAverage,"vote_count": $voteCount,"popularity": $popularity,"adult": $adult,"video": $video,"backdrop_path": ${backdropPath != null ? '${json.encode(backdropPath)}' : 'null'},"first_air_date": ${firstAirDate != null ? '${json.encode(firstAirDate)}' : 'null'},"media_type": ${mediaType != null ? '${json.encode(mediaType)}' : 'null'},"name": ${name != null ? '${json.encode(name)}' : 'null'},"original_language": ${originalLanguage != null ? '${json.encode(originalLanguage)}' : 'null'},"original_name": ${originalName != null ? '${json.encode(originalName)}' : 'null'},"original_title": ${originalTitle != null ? '${json.encode(originalTitle)}' : 'null'},"overview": ${overview != null ? '${json.encode(overview)}' : 'null'},"poster_path": ${posterPath != null ? '${json.encode(posterPath)}' : 'null'},"profile_path": ${profilePath != null ? '${json.encode(profilePath)}' : 'null'},"release_date": ${releaseDate != null ? '${json.encode(releaseDate)}' : 'null'},"title": ${title != null ? '${json.encode(title)}' : 'null'},"genre_ids": $genreIds,"known_for": $knownFor,"origin_country": $originCountry}';
  }
}

class KnownFor {
  double id;
  double voteCount;
  double popularity;
  double voteAverage;
  bool adult;
  bool video;
  String backdropPath;
  String mediaType;
  String originalLanguage;
  String originalTitle;
  String overview;
  String posterPath;
  String releaseDate;
  String title;
  List<int> genreIds;

  KnownFor.fromParams(
      {this.id,
      this.voteCount,
      this.popularity,
      this.voteAverage,
      this.adult,
      this.video,
      this.backdropPath,
      this.mediaType,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.posterPath,
      this.releaseDate,
      this.title,
      this.genreIds});

  KnownFor.fromJson(jsonRes) {
    id = double.parse(jsonRes['id']?.toString() ?? '0.0');
    voteCount = double.parse(jsonRes['vote_count']?.toString() ?? '0.0');
    popularity = double.parse(jsonRes['popularity']?.toString() ?? '0.0');
    voteAverage = double.parse(jsonRes['vote_average']?.toString() ?? '0.0');
    adult = jsonRes['adult'];
    video = jsonRes['video'];
    backdropPath = jsonRes['backdrop_path'];
    mediaType = jsonRes['media_type'];
    originalLanguage = jsonRes['original_language'];
    originalTitle = jsonRes['original_title'];
    overview = jsonRes['overview'];
    posterPath = jsonRes['poster_path'];
    releaseDate = jsonRes['release_date'];
    title = jsonRes['title'];
    genreIds = jsonRes['genre_ids'] == null ? null : [];

    for (var genreIdsItem in genreIds == null ? [] : jsonRes['genre_ids']) {
      genreIds.add(genreIdsItem);
    }
  }

  @override
  String toString() {
    return '{"id": $id,"vote_count": $voteCount,"popularity": $popularity,"vote_average": $voteAverage,"adult": $adult,"video": $video,"backdrop_path": ${backdropPath != null ? '${json.encode(backdropPath)}' : 'null'},"media_type": ${mediaType != null ? '${json.encode(mediaType)}' : 'null'},"original_language": ${originalLanguage != null ? '${json.encode(originalLanguage)}' : 'null'},"original_title": ${originalTitle != null ? '${json.encode(originalTitle)}' : 'null'},"overview": ${overview != null ? '${json.encode(overview)}' : 'null'},"poster_path": ${posterPath != null ? '${json.encode(posterPath)}' : 'null'},"release_date": ${releaseDate != null ? '${json.encode(releaseDate)}' : 'null'},"title": ${title != null ? '${json.encode(title)}' : 'null'},"genre_ids": $genreIds}';
  }
}
