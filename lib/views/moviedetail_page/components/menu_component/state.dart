import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/media_account_state_model.dart';

import '../../state.dart';

class MenuState implements Cloneable<MenuState> {
  int id;
  String backdropPic;
  String posterPic;
  String name;
  String overWatch;
  MediaAccountStateModel accountState;

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
    substate.posterPic = state.posterPic;
    substate.name = state.title;
    substate.accountState = state.accountState;
    substate.id = state.movieid;
    substate.backdropPic = state.backdropPic;
    substate.overWatch = state.movieDetailModel.overview;
    return substate;
  }

  @override
  void set(MovieDetailPageState state, MenuState subState) {
    state.accountState = subState.accountState;
  }
}
