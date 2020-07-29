 import 'dart:convert' show json;

class MediaAccountStateModel {

  int id;
  bool favorite;
  bool watchlist;
  RatedResult rated;
  bool isRated;

  MediaAccountStateModel.fromParams({this.id, this.favorite, this.watchlist, this.rated,this.isRated});

  factory MediaAccountStateModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? new MediaAccountStateModel.fromJson(json.decode(jsonStr)) : new MediaAccountStateModel.fromJson(jsonStr);
  
  MediaAccountStateModel.fromJson(jsonRes) {
    id = jsonRes['id'];
    favorite = jsonRes['favorite'];
    watchlist = jsonRes['watchlist'];
    rated = jsonRes['rated'] == false || jsonRes['rated'] ==null? null : new RatedResult.fromJson(jsonRes['rated']);
    isRated=jsonRes['rated'] == false|| jsonRes['rated'] ==null? false:true;
  }

  @override
  String toString() {
    return '{"id": $id,"favorite": $favorite,"watchlist": $watchlist,"rated": $rated,"isRated": $isRated}';
  }
}

class RatedResult {

  double value;

  RatedResult.fromParams({this.value});
  
  RatedResult.fromJson(jsonRes) {
    value =double.parse( jsonRes['value'].toString()??'0.0');
  }

  @override
  String toString() {
    return '{"value": $value}';
  }
}

