import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:movie/globalbasestate/state.dart';
import 'package:movie/models/base_api_model/transaction.dart';

class PaymentPageState implements GlobalBaseState, Cloneable<PaymentPageState> {
  TransactionModel transactions;
  @override
  PaymentPageState clone() {
    return PaymentPageState()
      ..transactions = transactions
      ..user = user;
  }

  @override
  Locale locale;

  @override
  Color themeColor;

  @override
  FirebaseUser user;
}

PaymentPageState initState(Map<String, dynamic> args) {
  return PaymentPageState();
}
