import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/app_user.dart';
import 'package:movie/views/account_page_old/state.dart';

class HeaderState implements Cloneable<HeaderState> {
  AppUser user;
  @override
  HeaderState clone() {
    return HeaderState();
  }
}

class HeaderConnector extends ConnOp<AccountPageState, HeaderState> {
  @override
  HeaderState get(AccountPageState state) {
    HeaderState substate = new HeaderState();
    substate.user = state.user;
    return substate;
  }
}
