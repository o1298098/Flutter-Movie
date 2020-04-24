import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_braintree/flutter_braintree.dart';

enum CheckOutPageAction { action, selectPaymentMethod, updatePaymentMethod }

class CheckOutPageActionCreator {
  static Action onAction() {
    return const Action(CheckOutPageAction.action);
  }

  static Action selectPaymentMethod() {
    return const Action(CheckOutPageAction.selectPaymentMethod);
  }

  static Action updatePaymentMethod(
      BraintreeDropInResult braintreeDropInResult) {
    return Action(CheckOutPageAction.updatePaymentMethod,
        payload: braintreeDropInResult);
  }
}
