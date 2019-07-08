import 'package:fish_redux/fish_redux.dart';

class HeaderState implements Cloneable<HeaderState> {

  String posterurl;
  String name;
  String overwatch;
  String airDate;

  HeaderState({this.name,this.overwatch,this.posterurl,this.airDate});

  @override
  HeaderState clone() {
    return HeaderState()
    ..posterurl=posterurl
    ..name=name
    ..overwatch;
  }
}

HeaderState initState(Map<String, dynamic> args) {
  return HeaderState();
}
