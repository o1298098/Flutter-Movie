import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/app_user.dart';
import 'package:movie/views/premium_page/state.dart';

class PlanState implements Cloneable<PlanState> {
  ScrollController scrollController;
  AppUser user;
  bool loading;
  @override
  PlanState clone() {
    return PlanState()
      ..user = user
      ..loading = loading
      ..scrollController = scrollController;
  }
}

class PlanConnector extends ConnOp<PremiumPageState, PlanState> {
  @override
  PlanState get(PremiumPageState state) {
    PlanState mstate = PlanState();
    mstate.scrollController = state.scrollController;
    mstate.user = state.user;
    mstate.loading = state.loading;
    return mstate;
  }

  @override
  void set(PremiumPageState state, PlanState subState) {
    state.loading = subState.loading;
  }
}
