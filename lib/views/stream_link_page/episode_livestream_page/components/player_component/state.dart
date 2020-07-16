import 'package:fish_redux/fish_redux.dart';

class PlayerState implements Cloneable<PlayerState> {

  @override
  PlayerState clone() {
    return PlayerState();
  }
}

PlayerState initState(Map<String, dynamic> args) {
  return PlayerState();
}
