import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/credits_model.dart';
import 'package:movie/views/seasondetail_page/state.dart';

class SeasonCastState implements Cloneable<SeasonCastState> {
  List<CastData> castData;
  int showcount;

  SeasonCastState({this.castData, this.showcount = 6});

  @override
  SeasonCastState clone() {
    return SeasonCastState()
      ..castData = castData
      ..showcount = showcount;
  }
}

class SeasonCastConnector
    extends ConnOp<SeasonDetailPageState, SeasonCastState> {
  @override
  SeasonCastState get(SeasonDetailPageState state) {
    SeasonCastState mstate = state.seasonCastState;
    return mstate;
  }
}
