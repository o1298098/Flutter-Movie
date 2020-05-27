import 'package:fish_redux/fish_redux.dart';

enum BillingAddressAction {
  action,
  create,
}

class BillingAddressActionCreator {
  static Action onAction() {
    return const Action(BillingAddressAction.action);
  }

  static Action onCreate() {
    return const Action(BillingAddressAction.create);
  }
}
