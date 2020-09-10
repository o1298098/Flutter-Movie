import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/models.dart';
import 'package:movie/views/peopledetail_page/state.dart';

class KnownForState implements Cloneable<KnownForState> {
  List<CombinedCastData> cast;

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
