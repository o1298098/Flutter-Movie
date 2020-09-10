import 'package:fish_redux/fish_redux.dart';
import 'package:movie/views/detail_page/state.dart';
import 'package:movie/models/models.dart';

class CastState implements Cloneable<CastState> {
  List<CastData> cast;
  @override
  CastState clone() {
    return CastState();
  }
}

class CastConnector extends ConnOp<MovieDetailPageState, CastState> {
  @override
  CastState get(MovieDetailPageState state) {
    CastState substate = new CastState();
    substate.cast = state.detail.credits?.cast ?? [];
    return substate;
  }
}
