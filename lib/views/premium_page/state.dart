import 'package:fish_redux/fish_redux.dart';

class PremiumPageState implements Cloneable<PremiumPageState> {

  @override
  PremiumPageState clone() {
    return PremiumPageState();
  }
}

PremiumPageState initState(Map<String, dynamic> args) {
  return PremiumPageState();
}
