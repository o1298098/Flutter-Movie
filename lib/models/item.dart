import 'dart:convert' show json;

class Item {
  String name;
  dynamic value;
  Item.fromParams({this.name, this.value});

  factory Item(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new Item.fromJson(json.decode(jsonStr))
          : new Item.fromJson(jsonStr);

  Item.fromJson(jsonRes) {
    name = jsonRes['name'];
    value = jsonRes['value'];
  }
  @override
  String toString() {
    return '{"name": "$name","value": ${value != null ? '${json.encode(value)}' : 'null'}}';
  }
}
