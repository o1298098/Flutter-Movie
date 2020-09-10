import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/credits_model.dart';
import 'package:movie/models/tvshow_detail.dart';
import 'package:movie/views/tvdetail_page/state.dart';

class TvInfoState implements Cloneable<TvInfoState> {
  String overView;
  List<CreatedBy> createdBy;
  List<CastData> cast;

  @override
  TvInfoState clone() {
    return TvInfoState();
  }
}

class TvInfoConnector extends ConnOp<TVDetailPageState, TvInfoState> {
  @override
  TvInfoState get(TVDetailPageState state) {
    TvInfoState substate = new TvInfoState();
    substate.createdBy = state.tvDetailModel.createdBy ?? List<CreatedBy>();
    substate.overView = state.tvDetailModel?.overview;
    substate.cast = state.tvDetailModel?.credits?.cast;
    return substate;
  }
}
