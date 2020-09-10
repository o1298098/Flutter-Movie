import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/app_user.dart';
import 'package:movie/models/base_api_model/braintree_subscription.dart';
import 'package:movie/views/premium_page/state.dart';

class PremiumInfoState implements Cloneable<PremiumInfoState> {
  AppUser user;
  BraintreeSubscription subscription;
  bool loading;
  @override
  PremiumInfoState clone() {
    return PremiumInfoState()..user = user;
  }
}

class PremiumInfoConnector extends ConnOp<PremiumPageState, PremiumInfoState> {
  @override
  PremiumInfoState get(PremiumPageState state) {
    PremiumInfoState mstate = PremiumInfoState();
    mstate.user = state.user;
    mstate.subscription = state.subscription;
    mstate.loading = state.loading;
    return mstate;
  }
}
