import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:movie/globalbasestate/state.dart';
import 'package:movie/models/app_user.dart';
import 'package:movie/models/base_api_model/braintree_subscription.dart';

class PremiumPageState implements GlobalBaseState, Cloneable<PremiumPageState> {
  BraintreeSubscription subscription;
  @override
  PremiumPageState clone() {
    return PremiumPageState()
      ..user = user
      ..subscription = subscription;
  }

  @override
  Locale locale;

  @override
  Color themeColor;

  @override
  AppUser user;
}

PremiumPageState initState(Map<String, dynamic> args) {
  return PremiumPageState();
}
