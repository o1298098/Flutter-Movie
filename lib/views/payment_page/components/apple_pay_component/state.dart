import 'package:fish_redux/fish_redux.dart';

class ApplePayState implements Cloneable<ApplePayState> {

  @override
  ApplePayState clone() {
    return ApplePayState();
  }
}

ApplePayState initState(Map<String, dynamic> args) {
  return ApplePayState();
}
