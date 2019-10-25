import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import '../../state.dart';

class Theme3State implements Cloneable<Theme3State> {
  String name;
  String avatar;
  bool islogin;
  int acountIdV3;
  String acountIdV4;
  AnimationController animationController;
  Locale local;
  @override
  Theme3State clone() {
    return Theme3State();
  }
}

class Theme3Connector extends ConnOp<AccountPageState, Theme3State> {
  @override
  Theme3State get(AccountPageState state) {
    Theme3State mstate = Theme3State();
    mstate.animationController = state.animationController;
    mstate.name = state.name;
    mstate.avatar = state.avatar;
    mstate.islogin = state.islogin;
    mstate.acountIdV3 = state.acountIdV3;
    mstate.acountIdV4 = state.acountIdV4;
    mstate.local = state.locale;
    return mstate;
  }
}
