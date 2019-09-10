import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/animation.dart';

import '../../state.dart';

class Theme2State implements Cloneable<Theme2State> {
  String name;
  String avatar;
  bool islogin;
  int acountIdV3;
  String acountIdV4;
  AnimationController animationController;
  @override
  Theme2State clone() {
    return Theme2State();
  }
}

class Theme2Connector extends ConnOp<AccountPageState, Theme2State> {
  @override
  Theme2State get(AccountPageState state) {
    Theme2State mstate = Theme2State();
    mstate.animationController = state.animationController;
    mstate.name = state.name;
    mstate.avatar = state.avatar;
    mstate.islogin = state.islogin;
    mstate.acountIdV3 = state.acountIdV3;
    mstate.acountIdV4 = state.acountIdV4;
    return mstate;
  }
}
