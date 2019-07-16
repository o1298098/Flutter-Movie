import 'package:fish_redux/fish_redux.dart';

class HistoryState implements Cloneable<HistoryState> {

  @override
  HistoryState clone() {
    return HistoryState();
  }
}

HistoryState initState(Map<String, dynamic> args) {
  return HistoryState();
}
