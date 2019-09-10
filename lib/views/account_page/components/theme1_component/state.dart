import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/animation.dart';

import '../../state.dart';

class Theme1State implements Cloneable<Theme1State> {
  String name;
  String avatar;
  bool islogin;
  int acountIdV3;
  String acountIdV4;
  AnimationController animationController;

  @override
  Theme1State clone() {
    return Theme1State();
  }
}

class Theme1Connector extends ConnOp<AccountPageState, Theme1State> {
  @override
  Theme1State get(AccountPageState state) {
    Theme1State mstate = Theme1State();
    mstate.animationController = state.animationController;
    mstate.name = state.name;
    mstate.avatar = state.avatar;
    mstate.islogin = state.islogin;
    mstate.acountIdV3 = state.acountIdV3;
    mstate.acountIdV4 = state.acountIdV4;
    return mstate;
  }
}
