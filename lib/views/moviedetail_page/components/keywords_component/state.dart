import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/keyword.dart';

import '../../state.dart';

class KeyWordsState implements Cloneable<KeyWordsState> {
  KeyWordModel keywords;
  @override
  KeyWordsState clone() {
    return KeyWordsState()
    ..keywords=keywords;
  }
}

KeyWordsState initKeyWordsState(Map<String, dynamic> args) {
  return KeyWordsState();
}
class KeyWordsConnector
    extends ConnOp<MovieDetailPageState, KeyWordsState> {
  @override
  KeyWordsState get(MovieDetailPageState state) {
    KeyWordsState mstate = KeyWordsState();
    mstate.keywords = state.movieDetailModel?.keywords??KeyWordModel.fromParams(keywords:[]);
    return mstate;
  }
}
