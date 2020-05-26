import 'package:fish_redux/fish_redux.dart';
import 'package:movie/views/payment_page/state.dart';

class BillingAddressState implements Cloneable<BillingAddressState> {
  @override
  BillingAddressState clone() {
    return BillingAddressState();
  }
}

class BillingAddressConnector
    extends ConnOp<PaymentPageState, BillingAddressState> {
  @override
  BillingAddressState get(PaymentPageState state) {
    BillingAddressState mstate = BillingAddressState();
    return mstate;
  }
}
