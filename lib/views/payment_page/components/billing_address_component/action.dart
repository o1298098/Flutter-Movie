import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/braintree_billing_address.dart';
import 'package:movie/models/base_api_model/stripe_address.dart';

enum BillingAddressAction {
  action,
  create,
  edit,
  insert,
  update,
  delete,
}

class BillingAddressActionCreator {
  static Action onAction() {
    return const Action(BillingAddressAction.action);
  }

  static Action onCreate() {
    return const Action(BillingAddressAction.create);
  }

  static Action onEdit(StripeAddress address) {
    return Action(BillingAddressAction.edit, payload: address);
  }

  static Action onInsert(BillingAddress address) {
    return Action(BillingAddressAction.insert, payload: address);
  }

  static Action onUpdate(StripeAddress address) {
    return Action(BillingAddressAction.update, payload: address);
  }

  static Action onDelete(StripeAddress address) {
    return Action(BillingAddressAction.delete, payload: address);
  }
}
