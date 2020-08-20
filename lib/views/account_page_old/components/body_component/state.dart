import 'package:fish_redux/fish_redux.dart';
import 'package:movie/views/account_page_old/state.dart';

class BodyState implements Cloneable<BodyState> {
  @override
  BodyState clone() {
    return BodyState();
  }
}

class BodyConnector extends ConnOp<AccountPageState, BodyState> {
  @override
  BodyState get(AccountPageState state) {
    BodyState substate = new BodyState();
    return substate;
  }
}
