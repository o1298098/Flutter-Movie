import 'dart:convert' show json;

class Language {
  int id;
  String code;
  String name;

  Language.fromParams({this.id, this.code, this.name});

  Language.fromJson(jsonRes) {
    id = jsonRes['id'];
    code = jsonRes['code'];
    name = jsonRes['name'];
  }

  @override
  String toString() {
    return '{"id": $id,"code": ${code != null ? '${json.encode(code)}' : 'null'},"name": ${name != null ? '${json.encode(name)}' : 'null'}}';
  }
}
