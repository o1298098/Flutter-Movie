import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/combinedcredits.dart';

class KnownForState implements Cloneable<KnownForState> {
  
  CombinedCreditsModel creditsModel;

  KnownForState({this.creditsModel});

  @override
  KnownForState clone() {
    return KnownForState()..creditsModel=creditsModel;
  }
}

KnownForState initState(Map<String, dynamic> args) {
  var state= KnownForState();
  state.creditsModel=CombinedCreditsModel.fromParams(cast: List<CastData>(),crew:List<CrewData>());
  return state;
}
