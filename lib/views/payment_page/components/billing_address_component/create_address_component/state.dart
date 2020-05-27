import 'package:fish_redux/fish_redux.dart';

import '../state.dart';

class CreateAddressState implements Cloneable<CreateAddressState> {
  @override
  CreateAddressState clone() {
    return CreateAddressState();
  }
}

class CreateAddressConnector
    extends ConnOp<BillingAddressState, CreateAddressState> {
  @override
  CreateAddressState get(BillingAddressState state) {
    CreateAddressState mstate = CreateAddressState();
    return mstate;
  }
}
