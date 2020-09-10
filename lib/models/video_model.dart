import 'dart:convert' show json;

class VideoModel {

  int id;
  List<VideoResult> results;

  VideoModel.fromParams({this.id, this.results});

  factory VideoModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? new VideoModel.fromJson(json.decode(jsonStr)) : new VideoModel.fromJson(jsonStr);
  
  VideoModel.fromJson(jsonRes) {
    id = jsonRes['id'];
    results = jsonRes['results'] == null ? null : [];

    for (var resultsItem in results == null ? [] : jsonRes['results']){
            results.add(resultsItem == null ? null : new VideoResult.fromJson(resultsItem));
    }
  }

  @override
  String toString() {
    return '{"id": $id,"results": $results}';
  }
}

class VideoResult {

  int size;
  String id;
  String iso_3166_1;
  String iso_639_1;
  String key;
  String name;
  String site;
  String type;

  VideoResult.fromParams({this.size, this.id, this.iso_3166_1, this.iso_639_1, this.key, this.name, this.site, this.type});
  
  VideoResult.fromJson(jsonRes) {
    size = jsonRes['size'];
    id = jsonRes['id'];
    iso_3166_1 = jsonRes['iso_3166_1'];
    iso_639_1 = jsonRes['iso_639_1'];
    key = jsonRes['key'];
    name = jsonRes['name'];
    site = jsonRes['site'];
    type = jsonRes['type'];
  }

  @override
  String toString() {
    return '{"size": $size,"id": ${id != null?'${json.encode(id)}':'null'},"iso_3166_1": ${iso_3166_1 != null?'${json.encode(iso_3166_1)}':'null'},"iso_639_1": ${iso_639_1 != null?'${json.encode(iso_639_1)}':'null'},"key": ${key != null?'${json.encode(key)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'},"site": ${site != null?'${json.encode(site)}':'null'},"type": ${type != null?'${json.encode(type)}':'null'}}';
  }
}

