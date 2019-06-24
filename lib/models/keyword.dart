import 'dart:convert' show json;

class KeyWordModel {

  int id;
  List<KeyWordData> keywords;
  List<KeyWordData> results;

  KeyWordModel.fromParams({this.id, this.keywords,this.results});

  factory KeyWordModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? new KeyWordModel.fromJson(json.decode(jsonStr)) : new KeyWordModel.fromJson(jsonStr);
  
  KeyWordModel.fromJson(jsonRes) {
    id = jsonRes['id'];
    keywords = jsonRes['keywords'] == null ? null : [];
    results = jsonRes['results'] == null ? null : [];

    for (var keywordsItem in keywords == null ? [] : jsonRes['keywords']){
            keywords.add(keywordsItem == null ? null : new KeyWordData.fromJson(keywordsItem));
    }
    for (var keywordsItem in results == null ? [] : jsonRes['results']){
            results.add(keywordsItem == null ? null : new KeyWordData.fromJson(keywordsItem));
    }
  }

  @override
  String toString() {
    return '{"id": $id,"keywords": $keywords,"results": $results}';
  }
}

class KeyWordData {

  int id;
  String name;

  KeyWordData.fromParams({this.id, this.name});
  
  KeyWordData.fromJson(jsonRes) {
    id = jsonRes['id'];
    name = jsonRes['name'];
  }

  @override
  String toString() {
    return '{"id": $id,"name": ${name != null?'${json.encode(name)}':'null'}}';
  }
}

