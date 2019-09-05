import 'package:fish_redux/fish_redux.dart';

class HeaderState implements Cloneable<HeaderState> {
  String profilePath;
  String profileName;
  String biography;
  String character;
  int peopleid;
  String birthday;
  String deathday;
  HeaderState(
      {this.peopleid,
      this.biography,
      this.profileName,
      this.profilePath,
      this.character,
      this.birthday,
      this.deathday});

  @override
  HeaderState clone() {
    return HeaderState();
  }
}

HeaderState initState(Map<String, dynamic> args) {
  var state = HeaderState();
  return state;
}
