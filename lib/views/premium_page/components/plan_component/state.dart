import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/views/premium_page/state.dart';

class PlanState implements Cloneable<PlanState> {
  ScrollController scrollController;
  @override
  PlanState clone() {
    return PlanState();
  }
}

class PlanConnector extends ConnOp<PremiumPageState, PlanState> {
  @override
  PlanState get(PremiumPageState state) {
    PlanState mstate = PlanState();
    mstate.scrollController = state.scrollController;
    return mstate;
  }
}
