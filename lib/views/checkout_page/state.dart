import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:movie/globalbasestate/state.dart';
import 'package:movie/models/base_api_model/checkout_model.dart';
import 'package:movie/models/app_user.dart';

class CheckOutPageState
    implements GlobalBaseState, Cloneable<CheckOutPageState> {
  CheckOutModel checkoutData;
  BraintreeDropInResult braintreeDropInResult;
  bool isSelected;
  bool loading;
  @override
  CheckOutPageState clone() {
    return CheckOutPageState()
      ..checkoutData = checkoutData
      ..braintreeDropInResult = braintreeDropInResult
      ..isSelected = isSelected
      ..user = user
      ..loading = loading;
  }

  @override
  Locale locale;

  @override
  Color themeColor;

  @override
  AppUser user;
}

CheckOutPageState initState(Map<String, dynamic> args) {
  final _state = CheckOutPageState();
  _state.isSelected = false;
  _state.loading = false;
  if (args?.containsKey('data') ?? false) _state.checkoutData = args['data'];
  return _state;
}
