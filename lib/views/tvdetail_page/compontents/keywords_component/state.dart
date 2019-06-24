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
    extends ConnOp<TVDetailPageState, KeyWordsState> {
  @override
  KeyWordsState get(TVDetailPageState state) {
    KeyWordsState mstate = KeyWordsState();
    mstate.keywords = state.keywords;
    return mstate;
  }
}
