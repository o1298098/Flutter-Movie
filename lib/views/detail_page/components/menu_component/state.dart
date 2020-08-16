import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/account_state.dart';
import 'package:movie/models/movie_detail.dart';

import '../../state.dart';

class MenuState implements Cloneable<MenuState> {
  int id;
  String backdropPic;
  String posterPic;
  String name;
  String overWatch;
  MovieDetailModel detail;
  AccountState accountState;

  @override
  MenuState clone() {
    return MenuState()
      ..accountState = accountState
      ..posterPic = posterPic
      ..backdropPic = backdropPic
      ..id = id
      ..overWatch = overWatch
      ..name = name;
  }
}

class MenuConnector extends ConnOp<MovieDetailPageState, MenuState> {
  @override
  MenuState get(MovieDetailPageState state) {
    MenuState substate = new MenuState();
    substate.posterPic = state.bgPic;
    substate.name = state.detail.title ?? '';
    substate.accountState = state.accountState;
    substate.id = state.mediaId;
    substate.backdropPic = state.detail.backdropPath;
    substate.overWatch = state.detail.overview;
    substate.detail = state.detail;
    return substate;
  }

  @override
  void set(MovieDetailPageState state, MenuState subState) {
    state.accountState = subState.accountState;
  }
}
