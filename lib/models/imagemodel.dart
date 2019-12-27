import 'dart:convert' show json;

class ImageModel {

  int id;
  List<ImageData> backdrops;
  List<ImageData> posters;

  ImageModel.fromParams({this.id, this.backdrops, this.posters});

  factory ImageModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? new ImageModel.fromJson(json.decode(jsonStr)) : new ImageModel.fromJson(jsonStr);
  
  ImageModel.fromJson(jsonRes) {
    id = jsonRes['id'];
    backdrops = jsonRes['backdrops'] == null ? null : [];

    for (var backdropsItem in backdrops == null ? [] : jsonRes['backdrops']){
            backdrops.add(backdropsItem == null ? null : new ImageData.fromJson(backdropsItem));
    }

    posters = jsonRes['posters'] == null ? null : [];

    for (var postersItem in posters == null ? [] : jsonRes['posters']){
            posters.add(postersItem == null ? null : new ImageData.fromJson(postersItem));
    }
  }

  @override
  String toString() {
    return '{"id": $id,"backdrops": $backdrops,"posters": $posters}';
  }
}

class ImageData {

  int height;
  Object voteAverage;
  int voteCount;
  int width;
  double aspectRatio;
  String filePath;
  String iso_639_1;

  ImageData.fromParams({this.height, this.voteAverage, this.voteCount, this.width, this.aspectRatio, this.filePath, this.iso_639_1});
  
  ImageData.fromJson(jsonRes) {
    height = jsonRes['height'];
    voteAverage = jsonRes['vote_average'];
    voteCount = jsonRes['vote_count'];
    width = jsonRes['width'];
    aspectRatio = jsonRes['aspect_ratio'];
    filePath = jsonRes['file_path'];
    iso_639_1 = jsonRes['iso_639_1'];
  }

  @override
  String toString() {
    return '{"height": $height,"vote_average": $voteAverage,"vote_count": $voteCount,"width": $width,"aspect_ratio": $aspectRatio,"file_path": ${filePath != null?'${json.encode(filePath)}':'null'},"iso_639_1": ${iso_639_1 != null?'${json.encode(iso_639_1)}':'null'}}';
  }
}

