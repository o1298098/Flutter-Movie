import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/account_state.dart';
import 'package:movie/models/tvshow_detail.dart';
import 'package:movie/views/tvshow_detail_page/state.dart';

class MenuState implements Cloneable<MenuState> {
  int id;
  String backdropPic;
  String posterPic;
  String name;
  String overWatch;
  AccountState accountState;
  TVDetailModel detail;

  @override
  MenuState clone() {
    return MenuState()
      ..accountState = accountState
      ..posterPic = posterPic
      ..backdropPic = backdropPic
      ..id = id
      ..overWatch = overWatch
      ..name = name
      ..detail = detail;
  }
}

class MenuConnector extends ConnOp<TvShowDetailState, MenuState> {
  @override
  MenuState get(TvShowDetailState state) {
    MenuState substate = new MenuState();
    substate.posterPic = state.tvDetailModel.posterPath;
    substate.name = state.tvDetailModel.name;
    substate.accountState = state.accountState;
    substate.id = state.tvid;
    substate.backdropPic = state.tvDetailModel.backdropPath;
    substate.overWatch = state.tvDetailModel.overview;
    substate.detail = state.tvDetailModel;
    return substate;
  }

  @override
  void set(TvShowDetailState state, MenuState subState) {
    state.accountState = subState.accountState;
  }
}
