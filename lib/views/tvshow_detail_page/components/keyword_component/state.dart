import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/keyword.dart';
import 'package:movie/views/tvshow_detail_page/state.dart';

class KeywordState implements Cloneable<KeywordState> {
  List<KeyWordData> keywords;
  @override
  KeywordState clone() {
    return KeywordState();
  }
}

class KeywordConnector extends ConnOp<TvShowDetailState, KeywordState> {
  @override
  KeywordState get(TvShowDetailState state) {
    KeywordState substate = new KeywordState();
    substate.keywords = state.tvDetailModel?.keywords?.results;
    return substate;
  }
}
