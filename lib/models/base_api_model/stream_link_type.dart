import 'dart:convert' show json;

class StreamLinkType {
  int id;
  String name;

  StreamLinkType.fromParams({this.id, this.name});

  StreamLinkType.fromJson(jsonRes) {
    id = jsonRes['id'];
    name = jsonRes['name'];
  }

  @override
  String toString() {
    return '{"id": $id,"name": ${name != null ? '${json.encode(name)}' : 'null'}}';
  }
}
