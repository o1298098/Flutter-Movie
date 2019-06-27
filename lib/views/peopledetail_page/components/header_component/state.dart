import 'package:fish_redux/fish_redux.dart';

class HeaderState implements Cloneable<HeaderState> {

  String profilePath;
  String profileName;
  String biography;
  int peopleid;
  HeaderState({this.peopleid,this.biography,this.profileName,this.profilePath});

  @override
  HeaderState clone() {
    return HeaderState();
  }
}

HeaderState initState(Map<String, dynamic> args) {
  var state=HeaderState();
  return state;
}
