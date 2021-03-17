import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/stripe_address.dart';
import 'package:movie/views/payment_page/state.dart';

import 'create_address_component/state.dart';

class BillingAddressState implements Cloneable<BillingAddressState> {
  StripeAddress address;
  CreateAddressState createAddressState;
  String customerName;
  String customerId;
  @override
  BillingAddressState clone() {
    return BillingAddressState()
      ..address = address
      ..customerId = customerId
      ..customerName = customerName
      ..createAddressState = createAddressState;
  }
}

class BillingAddressConnector
    extends ConnOp<PaymentPageState, BillingAddressState> {
  @override
  BillingAddressState get(PaymentPageState state) {
    BillingAddressState mstate = state.billingAddressState;
    return mstate;
  }

  @override
  void set(PaymentPageState state, BillingAddressState subState) {
    state.billingAddressState = subState;
    state.customer.address = subState.address;
  }
}
