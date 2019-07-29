import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/media_accountstatemodel.dart';

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
    ..accountState=accountState
    ..posterPic=posterPic
    ..backdropPic=backdropPic
    ..id=id
    ..overWatch=overWatch
    ..name=name;
  }
}

class MenuConnector extends ConnOp<TVDetailPageState,MenuState>{
  @override
  MenuState get(TVDetailPageState state) {
    MenuState substate=new MenuState();
    substate.posterPic=state.posterPic;
    substate.name=state.name;
    substate.accountState=state.accountState;
    substate.id=state.tvid;
    substate.backdropPic=state.backdropPic;
    substate.overWatch=state.tvDetailModel.overview;
    return substate;
  }
  @override
  void set(TVDetailPageState state, MenuState subState) {
    state.accountState=subState.accountState;
  }
}
