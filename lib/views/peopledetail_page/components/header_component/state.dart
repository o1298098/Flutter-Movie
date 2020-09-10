import 'package:fish_redux/fish_redux.dart';
import 'package:movie/views/peopledetail_page/state.dart';

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
    return HeaderState()
      ..biography = biography
      ..birthday = birthday
      ..character = character
      ..deathday = deathday
      ..peopleid = peopleid
      ..profileName = profileName
      ..profilePath = profilePath;
  }
}

class HeaderConnector extends ConnOp<PeopleDetailPageState, HeaderState> {
  @override
  HeaderState get(PeopleDetailPageState state) {
    HeaderState mstate = HeaderState();
    mstate.peopleid = state.peopleid;
    mstate.biography = state.peopleDetailModel.biography;
    mstate.profileName = state.profileName;
    mstate.profilePath = state.profilePath;
    mstate.character = state.character;
    mstate.deathday = state.peopleDetailModel.deathday;
    mstate.birthday = state.peopleDetailModel?.birthday;
    return mstate;
  }
}
