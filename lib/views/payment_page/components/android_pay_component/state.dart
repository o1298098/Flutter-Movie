import 'package:fish_redux/fish_redux.dart';

class AndroidPayState implements Cloneable<AndroidPayState> {

  @override
  AndroidPayState clone() {
    return AndroidPayState();
  }
}

AndroidPayState initState(Map<String, dynamic> args) {
  return AndroidPayState();
}
