import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/credits_model.dart';

class CreditsState implements Cloneable<CreditsState> {
  List<CastData> guestStars;
  List<CrewData> crew;

  CreditsState({this.crew, this.guestStars});

  @override
  CreditsState clone() {
    return CreditsState();
  }
}

CreditsState initState(Map<String, dynamic> args) {
  return CreditsState();
}
