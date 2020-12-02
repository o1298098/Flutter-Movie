import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/app_user.dart';
import 'package:movie/models/models.dart';
import 'package:movie/views/checkout_page/state.dart';

class PaymentState implements Cloneable<PaymentState> {
  bool nativePay;
  AppUser user;
  StripeCreditCard selectedCard;
  StripeCreditCards cards;
  @override
  PaymentState clone() {
    return PaymentState()
      ..cards = cards
      ..nativePay = nativePay
      ..user = user
      ..selectedCard = selectedCard;
  }
}

class PaymentConnector extends ConnOp<CheckOutPageState, PaymentState> {
  @override
  PaymentState get(CheckOutPageState state) {
    PaymentState substate = state.paymentState;
    substate.user = state.user;
    return substate;
  }

  @override
  void set(CheckOutPageState state, PaymentState subState) {
    state.paymentState = subState;
  }
}
