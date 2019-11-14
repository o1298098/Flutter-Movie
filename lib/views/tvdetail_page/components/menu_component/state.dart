import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/account_state.dart';
import 'package:movie/models/tvdetail.dart';

import '../../state.dart';

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

class MenuConnector extends ConnOp<TVDetailPageState, MenuState> {
  @override
  MenuState get(TVDetailPageState state) {
    MenuState substate = new MenuState();
    substate.posterPic = state.posterPic;
    substate.name = state.name;
    substate.accountState = state.accountState;
    substate.id = state.tvid;
    substate.backdropPic = state.backdropPic;
    substate.overWatch = state.tvDetailModel.overview;
    substate.detail = state.tvDetailModel;
    return substate;
  }

  @override
  void set(TVDetailPageState state, MenuState subState) {
    state.accountState = subState.accountState;
  }
}
