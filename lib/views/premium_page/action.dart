import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/braintree_subscription.dart';

enum PremiumPageAction { action, setSubscription, changePlan, loading }

class PremiumPageActionCreator {
  static Action onAction() {
    return const Action(PremiumPageAction.action);
  }

  static Action setSubscription(BraintreeSubscription subscription) {
    return Action(PremiumPageAction.setSubscription, payload: subscription);
  }

  static Action changePlan() {
    return Action(PremiumPageAction.changePlan);
  }

  static Action loading(bool loading) {
    return Action(PremiumPageAction.loading, payload: loading);
  }
}
