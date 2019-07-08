import 'package:fish_redux/fish_redux.dart';

class SeasonCrewState implements Cloneable<SeasonCrewState> {

  @override
  SeasonCrewState clone() {
    return SeasonCrewState();
  }
}

SeasonCrewState initState(Map<String, dynamic> args) {
  return SeasonCrewState();
}
