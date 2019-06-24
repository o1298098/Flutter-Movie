import 'package:fish_redux/fish_redux.dart';

class PeopleDetailPageState implements Cloneable<PeopleDetailPageState> {

  @override
  PeopleDetailPageState clone() {
    return PeopleDetailPageState();
  }
}

PeopleDetailPageState initState(Map<String, dynamic> args) {
  return PeopleDetailPageState();
}
