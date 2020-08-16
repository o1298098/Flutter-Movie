import 'dart:convert' show json;

class CombinedCastData {
  int id;
  int voteCount;
  double popularity;
  double voteAverage;
  bool adult;
  bool video;
  int episodeCount;
  String backdropPath;
  String character;
  String creditId;
  String mediaType;
  String originalLanguage;
  String originalTitle;
  String overview;
  String posterPath;
  String releaseDate;
  String title;
  String name;
  String originalName;
  String firstAirDate;
  List<int> genreIds;

  CombinedCastData.fromParams(
      {this.id,
      this.episodeCount,
      this.name,
      this.originalName,
      this.firstAirDate,
      this.voteCount,
      this.popularity,
      this.voteAverage,
      this.adult,
      this.video,
      this.backdropPath,
      this.character,
      this.creditId,
      this.mediaType,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.posterPath,
      this.releaseDate,
      this.title,
      this.genreIds});

  CombinedCastData.fromJson(jsonRes) {
    id = jsonRes['id'];
    voteCount = jsonRes['vote_count'];
    popularity = double.parse(jsonRes['popularity']?.toString() ?? '0');
    voteAverage = double.parse(jsonRes['vote_average']?.toString() ?? '0');
    adult = jsonRes['adult'];
    video = jsonRes['video'];
    backdropPath = jsonRes['backdrop_path'];
    character = jsonRes['character'];
    creditId = jsonRes['credit_id'];
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
    return '{"id": $id,"first_air_date": $firstAirDate,"original_name": $originalName,"name": $name,"episode_count": $episodeCount,,"vote_count": $voteCount,"popularity": $popularity,"vote_average": $voteAverage,"adult": $adult,"video": $video,"backdrop_path": ${backdropPath != null ? '${json.encode(backdropPath)}' : 'null'},"character": ${character != null ? '${json.encode(character)}' : 'null'},"credit_id": ${creditId != null ? '${json.encode(creditId)}' : 'null'},"media_type": ${mediaType != null ? '${json.encode(mediaType)}' : 'null'},"original_language": ${originalLanguage != null ? '${json.encode(originalLanguage)}' : 'null'},"original_title": ${originalTitle != null ? '${json.encode(originalTitle)}' : 'null'},"overview": ${overview != null ? '${json.encode(overview)}' : 'null'},"poster_path": ${posterPath != null ? '${json.encode(posterPath)}' : 'null'},"release_date": ${releaseDate != null ? '${json.encode(releaseDate)}' : 'null'},"title": ${title != null ? '${json.encode(title)}' : 'null'},"genre_ids": $genreIds}';
  }
}
