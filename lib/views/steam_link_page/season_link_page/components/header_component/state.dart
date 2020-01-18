import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/tvdetail.dart';
import 'package:movie/views/steam_link_page/season_link_page/state.dart';

class HeaderState implements Cloneable<HeaderState> {
  String name;
  List<Genre> genres;
  String posterPath;
  String overview;
  @override
  HeaderState clone() {
    return HeaderState();
  }
}

class HeaderConnector extends ConnOp<SeasonLinkPageState, HeaderState> {
  @override
  HeaderState get(SeasonLinkPageState state) {
    HeaderState mstate = HeaderState();
    mstate.name = state.detail?.name ?? '';
    mstate.posterPath = state.detail?.posterPath;
    mstate.overview = state.detail?.overview ?? '';
    mstate.genres = state.detail?.genres ?? [];
    return mstate;
  }
}
