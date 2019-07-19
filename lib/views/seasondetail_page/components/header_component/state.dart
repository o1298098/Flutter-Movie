import 'package:fish_redux/fish_redux.dart';

class HeaderState implements Cloneable<HeaderState> {

  String posterurl;
  String name;
  String overwatch;
  String airDate;
  int seasonNumber;

  HeaderState({this.name,this.overwatch,this.posterurl,this.airDate,this.seasonNumber});

  @override
  HeaderState clone() {
    return HeaderState()
    ..posterurl=posterurl
    ..name=name
    ..overwatch
    ..seasonNumber=seasonNumber;
  }
}

HeaderState initState(Map<String, dynamic> args) {
  return HeaderState();
}
