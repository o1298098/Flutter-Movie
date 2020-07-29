import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/combined_credits.dart';
import 'package:movie/views/peopledetail_page/state.dart';

class KnownForState implements Cloneable<KnownForState> {
  List<CastData> cast;

  KnownForState({this.cast});

  @override
  KnownForState clone() {
    return KnownForState()..cast = cast;
  }
}

class KnownForConnector extends ConnOp<PeopleDetailPageState, KnownForState> {
  @override
  KnownForState get(PeopleDetailPageState state) {
    KnownForState mstate = KnownForState();
    mstate.cast = state.knowForCast ?? [];
    return mstate;
  }
}
