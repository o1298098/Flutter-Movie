import 'dart:convert' show json;

class ItemType {
  String type;
  String value;

  ItemType.fromParams({this.type, this.value});

  ItemType.fromJson(jsonRes) {
    type = jsonRes['type'];
    value = jsonRes['value'];
  }

  @override
  String toString() {
    return '{"type": ${type != null ? '${json.encode(type)}' : 'null'},"value": ${value != null ? '${json.encode(value)}' : 'null'}}';
  }
}
