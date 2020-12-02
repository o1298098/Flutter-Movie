import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/base_api_model/stripe_address.dart';
import 'package:movie/models/country_phone_code.dart';

import '../state.dart';

class CreateAddressState implements Cloneable<CreateAddressState> {
  List<CountryPhoneCode> countries;
  bool loading;
  String customerId;
  String customerName;
  StripeAddress address;
  CountryPhoneCode region;
  TextEditingController firstNameController;
  TextEditingController lastNameController;
  TextEditingController companyController;
  TextEditingController cityController;
  TextEditingController provinceController;
  TextEditingController postalCodeController;
  TextEditingController streetAddressController;
  TextEditingController extendedAddressController;
  @override
  CreateAddressState clone() {
    return CreateAddressState()
      ..customerId = customerId
      ..customerName = customerName
      ..countries = countries
      ..loading = loading
      ..address = address
      ..region = region
      ..firstNameController = firstNameController
      ..lastNameController = lastNameController
      ..companyController = companyController
      ..cityController = cityController
      ..provinceController = provinceController
      ..postalCodeController = postalCodeController
      ..streetAddressController = streetAddressController
      ..extendedAddressController = extendedAddressController;
  }
}

class CreateAddressConnector
    extends ConnOp<BillingAddressState, CreateAddressState> {
  @override
  CreateAddressState get(BillingAddressState state) {
    CreateAddressState mstate = state.createAddressState;
    return mstate;
  }

  @override
  void set(BillingAddressState state, CreateAddressState subState) {
    state.createAddressState = subState;
  }
}
