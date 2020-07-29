import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/combined_credits.dart';

class KnownForState implements Cloneable<KnownForState> {
  List<CastData> cast;

  KnownForState({this.cast});

  @override
  KnownForState clone() {
    return KnownForState()..cast = cast;
  }
}

KnownForState initState(Map<String, dynamic> args) {
  var state = KnownForState();
  state.cast = List<CastData>();
  return state;
}
