import 'package:fish_redux/fish_redux.dart';
import 'package:movie/views/detail_page/state.dart';

class OverViewState implements Cloneable<OverViewState> {
  String overView;
  @override
  OverViewState clone() {
    return OverViewState();
  }
}

class OverViewConnector extends ConnOp<MovieDetailPageState, OverViewState> {
  @override
  OverViewState get(MovieDetailPageState state) {
    OverViewState substate = new OverViewState();
    substate.overView = state.detail?.overview;
    return substate;
  }
}
