import 'dart:convert' show json;

class VideoListModel {

  int page;
  int totalPages;
  int totalResults;
  List< VideoListResult> results;
  DateString dates;

  VideoListModel.fromParams({this.page, this.totalPages, this.totalResults, this.results, this.dates});

  factory VideoListModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? new VideoListModel.fromJson(json.decode(jsonStr)) : new VideoListModel.fromJson(jsonStr);
  
  VideoListModel.fromJson(jsonRes) {
    page = jsonRes['page'];
    totalPages = jsonRes['total_pages'];
    totalResults = jsonRes['total_results'];
    results = jsonRes['results'] == null ? null : [];

    for (var resultsItem in results == null ? [] : jsonRes['results']){
            results.add(resultsItem == null ? null : new VideoListResult.fromJson(resultsItem));
    }

    dates = jsonRes['dates'] == null ? null : new DateString.fromJson(jsonRes['dates']);
  }

  @override
  String toString() {
    return '{"page": $page,"total_pages": $totalPages,"total_results": $totalResults,"results": $results,"dates": $dates}';
  }
}

class DateString {

  String maximum;
  String minimum;

  DateString.fromParams({this.maximum, this.minimum});
  
  DateString.fromJson(jsonRes) {
    maximum = jsonRes['maximum'];
    minimum = jsonRes['minimum'];
  }

  @override
  String toString() {
    return '{"maximum": ${maximum != null?'${json.encode(maximum)}':'null'},"minimum": ${minimum != null?'${json.encode(minimum)}':'null'}}';
  }
}

class VideoListResult {

  int id;
  int voteCount;
  double popularity;
  double voteAverage;
  bool adult;
  bool video;
  double rating;
  String backdropPath;
  String originalLanguage;
  List<String> originCountry;
  String originalTitle;
  String originalName;
  String firstAirDate;
  String name;
  String overview;
  String posterPath;
  String releaseDate;
  String title;
  List<int> genreIds;
  String season;
  String nextEpisodeName;
  String nextEpisodeNumber;
  String nextAirDate;
  String mediaType;

  VideoListResult.fromParams({this.id,this.rating,this.nextEpisodeName,this.nextEpisodeNumber,this.nextAirDate,this.season, this.voteCount, this.popularity, this.voteAverage, this.adult, this.video, this.backdropPath, this.originalLanguage, this.originalTitle, this.overview, this.posterPath, this.releaseDate, this.title, this.genreIds,this.firstAirDate, this.name, this.originalName, this.originCountry,this.mediaType});
  
  VideoListResult.fromJson(jsonRes) {
    id = jsonRes['id'];
    voteCount = jsonRes['vote_count'];
    popularity =double.tryParse(jsonRes['popularity'].toString());
    voteAverage =double.parse(jsonRes['vote_average'].toString());
    rating =double.parse(jsonRes['rating']?.toString()??'0.0');
    adult = jsonRes['adult'];
    video = jsonRes['video'];
    backdropPath = jsonRes['backdrop_path'];
    originalLanguage = jsonRes['original_language'];
    originalTitle = jsonRes['original_title'];
    overview = jsonRes['overview'];
    posterPath = jsonRes['poster_path'];
    releaseDate = jsonRes['release_date'];
    title = jsonRes['title'];
    genreIds = jsonRes['genre_ids'] == null ? null : [];
    originalName = jsonRes['original_name'];
    name = jsonRes['name'];
    firstAirDate = jsonRes['first_air_date'];
    originCountry = jsonRes['origin_country'] == null ? null : [];
    mediaType=jsonRes['media_type'];

    for (var origin_countryItem in originCountry == null ? [] : jsonRes['origin_country']){
            originCountry.add(origin_countryItem);
    }

    for (var genre_idsItem in genreIds == null ? [] : jsonRes['genre_ids']){
            genreIds.add(genre_idsItem);
    }
  }

  @override
  String toString() {
    return '{"id": $id,"rating": $rating,"mediaType":$mediaType,"vote_count": $voteCount,"popularity": $popularity,"vote_average": $voteAverage,"adult": $adult,"video": $video,"backdrop_path": ${backdropPath != null?'${json.encode(backdropPath)}':'null'},"original_language": ${originalLanguage != null?'${json.encode(originalLanguage)}':'null'},"original_title": ${originalTitle != null?'${json.encode(originalTitle)}':'null'},"overview": ${overview != null?'${json.encode(overview)}':'null'},"poster_path": ${posterPath != null?'${json.encode(posterPath)}':'null'},"release_date": ${releaseDate != null?'${json.encode(releaseDate)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'},"genre_ids": $genreIds,"first_air_date": ${firstAirDate != null?'${json.encode(firstAirDate)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'},"original_language": ${originalLanguage != null?'${json.encode(originalLanguage)}':'null'},"original_name": ${originalName != null?'${json.encode(originalName)}':'null'},"origin_country": $originCountry}';
  }
}

