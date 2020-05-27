import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/braintree_billing_address.dart';
import 'package:movie/views/payment_page/state.dart';

class BillingAddressState implements Cloneable<BillingAddressState> {
  List<BillingAddress> addresses;
  @override
  BillingAddressState clone() {
    return BillingAddressState()..addresses = addresses;
  }
}

class BillingAddressConnector
    extends ConnOp<PaymentPageState, BillingAddressState> {
  @override
  BillingAddressState get(PaymentPageState state) {
    BillingAddressState mstate = BillingAddressState();
    mstate.addresses = state.customer?.addresses;
    return mstate;
  }
}
