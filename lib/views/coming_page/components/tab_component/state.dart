import 'package:fish_redux/fish_redux.dart';
import 'package:movie/views/coming_page/state.dart';

class TabState implements Cloneable<TabState> {
  bool showMovie;
  @override
  TabState clone() {
    return TabState()..showMovie = showMovie;
  }
}

class TabConnector extends ConnOp<ComingPageState, TabState> {
  @override
  TabState get(ComingPageState state) {
    TabState substate = new TabState();
    substate.showMovie = state.showmovie;
    return substate;
  }
}
