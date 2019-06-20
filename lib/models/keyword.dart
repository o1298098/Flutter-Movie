import 'dart:convert' show json;

class KeyWordModel {

  int id;
  List<KeyWordData> keywords;

  KeyWordModel.fromParams({this.id, this.keywords});

  factory KeyWordModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? new KeyWordModel.fromJson(json.decode(jsonStr)) : new KeyWordModel.fromJson(jsonStr);
  
  KeyWordModel.fromJson(jsonRes) {
    id = jsonRes['id'];
    keywords = jsonRes['keywords'] == null ? null : [];

    for (var keywordsItem in keywords == null ? [] : jsonRes['keywords']){
            keywords.add(keywordsItem == null ? null : new KeyWordData.fromJson(keywordsItem));
    }
  }

  @override
  String toString() {
    return '{"id": $id,"keywords": $keywords}';
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

