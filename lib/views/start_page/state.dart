import 'package:fish_redux/fish_redux.dart';

class StartPageState implements Cloneable<StartPageState> {
  @override
  StartPageState clone() {
    return StartPageState();
  }
}

StartPageState initState(Map<String, dynamic> args) {
  return StartPageState();
}
