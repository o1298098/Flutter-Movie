import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/models.dart';

enum PaymentAction {
  action,
  selectPayment,
  updateNatviePayValue,
  updateSelectedCard
}

class PaymentActionCreator {
  static Action onAction() {
    return const Action(PaymentAction.action);
  }

  static Action selectPayment(bool isNativePay) {
    return Action(PaymentAction.selectPayment, payload: isNativePay);
  }

  static Action updateNatviePayValue(bool isNativePay) {
    return Action(PaymentAction.updateNatviePayValue, payload: isNativePay);
  }

  static Action updateSelectedCard(StripeCreditCard card) {
    return Action(PaymentAction.updateSelectedCard, payload: card);
  }
}
