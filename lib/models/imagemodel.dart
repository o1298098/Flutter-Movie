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
  Object vote_average;
  int vote_count;
  int width;
  double aspect_ratio;
  String file_path;
  String iso_639_1;

  ImageData.fromParams({this.height, this.vote_average, this.vote_count, this.width, this.aspect_ratio, this.file_path, this.iso_639_1});
  
  ImageData.fromJson(jsonRes) {
    height = jsonRes['height'];
    vote_average = jsonRes['vote_average'];
    vote_count = jsonRes['vote_count'];
    width = jsonRes['width'];
    aspect_ratio = jsonRes['aspect_ratio'];
    file_path = jsonRes['file_path'];
    iso_639_1 = jsonRes['iso_639_1'];
  }

  @override
  String toString() {
    return '{"height": $height,"vote_average": $vote_average,"vote_count": $vote_count,"width": $width,"aspect_ratio": $aspect_ratio,"file_path": ${file_path != null?'${json.encode(file_path)}':'null'},"iso_639_1": ${iso_639_1 != null?'${json.encode(iso_639_1)}':'null'}}';
  }
}

