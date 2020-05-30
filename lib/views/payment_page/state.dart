import 'dart:ui';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movie/globalbasestate/state.dart';
import 'package:movie/models/base_api_model/braintree_customer.dart';
import 'package:movie/models/app_user.dart';
import 'package:movie/models/base_api_model/braintree_transaction.dart';

import 'components/billing_address_component/state.dart';
import 'components/create_card_component/state.dart';

class PaymentPageState implements GlobalBaseState, Cloneable<PaymentPageState> {
  BillingAddressState billingAddressState;
  CreateCardState createCardState;
  TransactionModel transactions;
  BraintreeCustomer customer;
  SwiperController swiperController;
  bool loading;
  @override
  PaymentPageState clone() {
    return PaymentPageState()
      ..transactions = transactions
      ..customer = customer
      ..swiperController = swiperController
      ..user = user
      ..loading = loading
      ..billingAddressState = billingAddressState
      ..createCardState = createCardState;
  }

  @override
  Locale locale;

  @override
  Color themeColor;

  @override
  AppUser user;
}

PaymentPageState initState(Map<String, dynamic> args) {
  return PaymentPageState()
    ..loading = false
    ..createCardState = CreateCardState()
    ..billingAddressState = BillingAddressState();
}
