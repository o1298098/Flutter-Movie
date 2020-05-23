import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/app_user.dart';
import 'package:movie/views/premium_page/components/premium_info_component/state.dart';

class HeaderState implements Cloneable<HeaderState> {
  AppUser user;
  @override
  HeaderState clone() {
    return HeaderState();
  }
}

class HeaderConnector extends ConnOp<PremiumInfoState, HeaderState> {
  @override
  HeaderState get(PremiumInfoState state) {
    HeaderState mstate = HeaderState();
    mstate.user = state.user;
    return mstate;
  }
}
