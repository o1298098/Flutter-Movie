import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/braintree_billing_address.dart';

enum BillingAddressAction {
  action,
  create,
  edit,
}

class BillingAddressActionCreator {
  static Action onAction() {
    return const Action(BillingAddressAction.action);
  }

  static Action onCreate() {
    return const Action(BillingAddressAction.create);
  }

  static Action onEdit(BillingAddress address) {
    return Action(BillingAddressAction.edit, payload: address);
  }
}
