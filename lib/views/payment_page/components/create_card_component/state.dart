import 'package:fish_redux/fish_redux.dart';
import 'package:movie/views/payment_page/state.dart';

class CreateCardState implements Cloneable<CreateCardState> {
  @override
  CreateCardState clone() {
    return CreateCardState();
  }
}

class CreateCardConnector extends ConnOp<PaymentPageState, CreateCardState> {
  @override
  CreateCardState get(PaymentPageState state) {
    CreateCardState mstate = CreateCardState();
    return mstate;
  }
}
