import 'dart:convert' show json;

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/models/base_api_model/braintree_billing_address.dart';
import 'package:movie/models/country_phone_code.dart';
import 'action.dart';
import 'create_address_component/state.dart';
import 'state.dart';

Effect<BillingAddressState> buildEffect() {
  return combineEffects(<Object, Effect<BillingAddressState>>{
    BillingAddressAction.action: _onAction,
    BillingAddressAction.create: _onCreate,
    BillingAddressAction.edit: _onEdit,
    Lifecycle.initState: _onInit,
  });
}

void _onAction(Action action, Context<BillingAddressState> ctx) {}

void _onInit(Action action, Context<BillingAddressState> ctx) async {
  ctx.state.createAddressState = CreateAddressState();
  final _jsonStr = await CountryPhoneCode.getCountryJson(ctx.context);
  final _countriesJson = json.decode(_jsonStr);
  final _countries = List<CountryPhoneCode>();
  for (var _country in _countriesJson) {
    _countries.add(CountryPhoneCode.fromJson(_country));
  }
  ctx.state.createAddressState.countries = _countries;

  ctx.state.createAddressState.customerId = ctx.state.customerId;
}

Future _onCreate(Action action, Context<BillingAddressState> ctx) async {
  ctx.state.createAddressState.region = null;
  ctx.state.createAddressState.billingAddress = null;
  await Navigator.of(ctx.context).push(
      MaterialPageRoute(builder: (_) => ctx.buildComponent('createAddress')));
}

Future _onEdit(Action action, Context<BillingAddressState> ctx) async {
  final BillingAddress _address = action.payload;
  ctx.state.createAddressState.region =
      ctx.state.createAddressState.countries.firstWhere(
    (e) => e.code == _address.countryCodeAlpha2,
    orElse: () => null,
  );
  ctx.state.createAddressState.billingAddress = _address;
  await Navigator.of(ctx.context).push(
      MaterialPageRoute(builder: (_) => ctx.buildComponent('createAddress')));
}
