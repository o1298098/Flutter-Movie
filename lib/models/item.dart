import 'dart:convert';

class Item {
  String name;
  dynamic value;
  Item({this.name, this.value});
  @override
  String toString() {
    return '{"name": "$name","value": ${value != null ? '${json.encode(value)}' : 'null'}}';
  }
}
