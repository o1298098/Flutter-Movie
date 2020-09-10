import 'dart:convert' show json;

class Genre {
  int id;
  String name;

  Genre.fromParams({this.id, this.name});

  Genre.fromJson(jsonRes) {
    id = jsonRes['id'];
    name = jsonRes['name'];
  }

  @override
  String toString() {
    return '{"id": $id,"name": ${name != null ? '${json.encode(name)}' : 'null'}}';
  }
}
