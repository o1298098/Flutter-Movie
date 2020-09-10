import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/credits_model.dart';
import 'package:movie/views/tvshow_detail_page/state.dart';

class CastState implements Cloneable<CastState> {
  List<CastData> casts;
  @override
  CastState clone() {
    return CastState();
  }
}

class CastConnector extends ConnOp<TvShowDetailState, CastState> {
  @override
  CastState get(TvShowDetailState state) {
    CastState substate = new CastState();
    substate.casts = state.tvDetailModel?.credits?.cast;
    return substate;
  }
}
