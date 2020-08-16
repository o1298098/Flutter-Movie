import 'dart:convert' show json;

class CombinedCrewData {
  int id;
  double voteAverage;
  int voteCount;
  double popularity;
  bool adult;
  bool video;
  String backdropPath;
  String creditId;
  String department;
  String job;
  String mediaType;
  String originalLanguage;
  String originalTitle;
  String overview;
  String posterPath;
  String releaseDate;
  String title;
  List<int> genreIds;
  int episodeCount;
  String name;
  String originalName;
  String firstAirDate;

  CombinedCrewData.fromParams(
      {this.id,
      this.episodeCount,
      this.name,
      this.originalName,
      this.firstAirDate,
      this.voteAverage,
      this.voteCount,
      this.popularity,
      this.adult,
      this.video,
      this.backdropPath,
      this.creditId,
      this.department,
      this.job,
      this.mediaType,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.posterPath,
      this.releaseDate,
      this.title,
      this.genreIds});

  CombinedCrewData.fromJson(jsonRes) {
    id = jsonRes['id'];
    voteAverage = double.parse(jsonRes['vote_average']?.toString() ?? '0');
    voteCount = jsonRes['vote_count'];
    popularity = double.parse(jsonRes['popularity']?.toString() ?? '0');
    adult = jsonRes['adult'];
    video = jsonRes['video'];
    backdropPath = jsonRes['backdrop_path'];
    creditId = jsonRes['credit_id'];
    department = jsonRes['department'];
    job = jsonRes['job'];
    mediaType = jsonRes['media_type'];
    originalLanguage = jsonRes['original_language'];
    originalTitle = jsonRes['original_title'];
    overview = jsonRes['overview'];
    posterPath = jsonRes['poster_path'];
    releaseDate = jsonRes['release_date'];
    title = jsonRes['title'];
    genreIds = jsonRes['genre_ids'] == null ? null : [];
    episodeCount = jsonRes['episode_count'];
    name = jsonRes['name'];
    originalName = jsonRes['original_name'];
    firstAirDate = jsonRes['first_air_date'];

    for (var genre_idsItem in genreIds == null ? [] : jsonRes['genre_ids']) {
      genreIds.add(genre_idsItem);
    }
  }

  @override
  String toString() {
    return '{"id": $id,"first_air_date": $firstAirDate,"original_name": $originalName,"name": $name,"episode_count": $episodeCount,"vote_average": $voteAverage,"vote_count": $voteCount,"popularity": $popularity,"adult": $adult,"video": $video,"backdrop_path": ${backdropPath != null ? '${json.encode(backdropPath)}' : 'null'},"credit_id": ${creditId != null ? '${json.encode(creditId)}' : 'null'},"department": ${department != null ? '${json.encode(department)}' : 'null'},"job": ${job != null ? '${json.encode(job)}' : 'null'},"media_type": ${mediaType != null ? '${json.encode(mediaType)}' : 'null'},"original_language": ${originalLanguage != null ? '${json.encode(originalLanguage)}' : 'null'},"original_title": ${originalTitle != null ? '${json.encode(originalTitle)}' : 'null'},"overview": ${overview != null ? '${json.encode(overview)}' : 'null'},"poster_path": ${posterPath != null ? '${json.encode(posterPath)}' : 'null'},"release_date": ${releaseDate != null ? '${json.encode(releaseDate)}' : 'null'},"title": ${title != null ? '${json.encode(title)}' : 'null'},"genre_ids": $genreIds}';
  }
}
