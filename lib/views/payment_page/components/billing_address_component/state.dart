import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/braintree_billing_address.dart';
import 'package:movie/views/payment_page/state.dart';

import 'create_address_component/state.dart';

class BillingAddressState implements Cloneable<BillingAddressState> {
  List<BillingAddress> addresses;
  CreateAddressState createAddressState;
  String customerId;
  @override
  BillingAddressState clone() {
    return BillingAddressState()
      ..addresses = addresses
      ..customerId = customerId
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
  }
}
