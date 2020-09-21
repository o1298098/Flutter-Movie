import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/actions/api/base_api.dart';
import 'package:movie/models/base_api_model/braintree_billing_address.dart';
import 'package:movie/views/payment_page/components/billing_address_component/action.dart';
import 'action.dart';
import 'state.dart';

Effect<CreateAddressState> buildEffect() {
  return combineEffects(<Object, Effect<CreateAddressState>>{
    CreateAddressAction.action: _onAction,
    CreateAddressAction.save: _onSave,
    CreateAddressAction.delete: _onDelete,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
  });
}

void _onAction(Action action, Context<CreateAddressState> ctx) {}

void _onInit(Action action, Context<CreateAddressState> ctx) async {
  ctx.state.loading = false;
  ctx.state.firstNameController = TextEditingController();
  ctx.state.lastNameController = TextEditingController();
  ctx.state.companyController = TextEditingController();
  ctx.state.cityController = TextEditingController();
  ctx.state.provinceController = TextEditingController();
  ctx.state.postalCodeController = TextEditingController();
  ctx.state.streetAddressController = TextEditingController();
  ctx.state.extendedAddressController = TextEditingController();
  if (ctx.state.billingAddress != null) {
    ctx.state.firstNameController.text = ctx.state.billingAddress.firstName;
    ctx.state.lastNameController.text = ctx.state.billingAddress.lastName;
    ctx.state.companyController.text = ctx.state.billingAddress.company;
    ctx.state.cityController.text = ctx.state.billingAddress.locality;
    ctx.state.provinceController.text = ctx.state.billingAddress.region;
    ctx.state.postalCodeController.text = ctx.state.billingAddress.postalCode;
    ctx.state.streetAddressController.text =
        ctx.state.billingAddress.streetAddress;
    ctx.state.extendedAddressController.text =
        ctx.state.billingAddress.extendedAddress;
  }
}

void _onDispose(Action action, Context<CreateAddressState> ctx) async {
  ctx.state.firstNameController.dispose();
  ctx.state.lastNameController.dispose();
  ctx.state.companyController.dispose();
  ctx.state.cityController.dispose();
  ctx.state.provinceController.dispose();
  ctx.state.postalCodeController.dispose();
  ctx.state.streetAddressController.dispose();
  ctx.state.extendedAddressController.dispose();
}

void _onSave(Action action, Context<CreateAddressState> ctx) async {
  ctx.dispatch(CreateAddressActionCreator.onLoading(true));
  final _address = BillingAddress.fromParams(
      customerId: ctx.state.customerId,
      company: ctx.state.companyController.text,
      firstName: ctx.state.firstNameController.text,
      countryName: ctx.state.region.name,
      extendedAddress: ctx.state.extendedAddressController.text,
      lastName: ctx.state.lastNameController.text,
      locality: ctx.state.cityController.text,
      postalCode: ctx.state.postalCodeController.text,
      region: ctx.state.provinceController.text,
      streetAddress: ctx.state.streetAddressController.text);
  final _baseApi = BaseApi.instance;
  if (ctx.state.billingAddress != null) {
    _address.id = ctx.state.billingAddress.id;
    var _r = await _baseApi.updateBillAddress(_address);
    if (_r != null) ctx.dispatch(BillingAddressActionCreator.onUpdate(_r));
    Navigator.of(ctx.context).pop();
  } else {
    var _r = await _baseApi.createBillAddress(_address);
    if (_r != null) ctx.dispatch(BillingAddressActionCreator.onInsert(_r));
    Navigator.of(ctx.context).pop();
  }

  ctx.dispatch(CreateAddressActionCreator.onLoading(false));
}

void _onDelete(Action action, Context<CreateAddressState> ctx) async {
  if (ctx.state.billingAddress != null && ctx.state.customerId != null) {
    final _baseApi = BaseApi.instance;
    ctx.dispatch(CreateAddressActionCreator.onLoading(true));
    final _r = await _baseApi.deleteBillAddress(ctx.state.billingAddress);
    if (_r != null) {
      ctx.dispatch(
          BillingAddressActionCreator.onDelete(ctx.state.billingAddress));

      ctx.dispatch(CreateAddressActionCreator.onLoading(false));
      Navigator.of(ctx.context).pop();
    }
  }
}
