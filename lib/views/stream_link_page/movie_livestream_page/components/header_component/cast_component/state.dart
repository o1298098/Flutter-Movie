import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/credits_model.dart';

import '../state.dart';

class CastState implements Cloneable<CastState> {
  List<CastData> casts;
  @override
  CastState clone() {
    return CastState()..casts = casts;
  }
}

class CastConnector extends ConnOp<HeaderState, CastState> {
  @override
  CastState get(HeaderState state) {
    CastState mstate = CastState();
    mstate.casts = state.detail?.credits?.cast ?? [];
    return mstate;
  }
}
