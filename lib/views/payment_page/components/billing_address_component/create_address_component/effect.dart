import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/actions/api/base_api.dart';
import 'package:movie/models/base_api_model/stripe_address.dart';
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
  if (ctx.state.address != null) {
    ctx.state.firstNameController.text = ctx.state.customerName;
    ctx.state.cityController.text = ctx.state.address.city;
    ctx.state.provinceController.text = ctx.state.address.state;
    ctx.state.postalCodeController.text = ctx.state.address.postalCode;
    ctx.state.streetAddressController.text = ctx.state.address.line1;
    ctx.state.extendedAddressController.text = ctx.state.address.line2;
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
  final _address = StripeAddress(
      country: ctx.state.region.code,
      line2: ctx.state.extendedAddressController.text,
      city: ctx.state.cityController.text,
      postalCode: ctx.state.postalCodeController.text,
      state: ctx.state.provinceController.text,
      line1: ctx.state.streetAddressController.text);
  final _baseApi = BaseApi.instance;
  if (ctx.state.customerId != null) {
    var _r = await _baseApi.updateStripeAddress(
        ctx.state.customerId, ctx.state.customerName, _address);
    if (_r != null) ctx.dispatch(BillingAddressActionCreator.onUpdate(_r));
    Navigator.of(ctx.context).pop();
  }

  ctx.dispatch(CreateAddressActionCreator.onLoading(false));
}

void _onDelete(Action action, Context<CreateAddressState> ctx) async {
  if (ctx.state.customerId != null) {
    final _baseApi = BaseApi.instance;
    ctx.dispatch(CreateAddressActionCreator.onLoading(true));
    final _r = await _baseApi.deleteStripeAddress(ctx.state.customerId);
    ctx.dispatch(CreateAddressActionCreator.onLoading(false));
    if (_r != null) {
      Navigator.of(ctx.context).pop();
    }
  }
}
