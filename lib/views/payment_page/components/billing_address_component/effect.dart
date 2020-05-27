import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'action.dart';
import 'state.dart';

Effect<BillingAddressState> buildEffect() {
  return combineEffects(<Object, Effect<BillingAddressState>>{
    BillingAddressAction.action: _onAction,
    BillingAddressAction.create: _onCreate,
    Lifecycle.initState: _onInit,
  });
}

void _onAction(Action action, Context<BillingAddressState> ctx) {}

void _onInit(Action action, Context<BillingAddressState> ctx) {}

Future _onCreate(Action action, Context<BillingAddressState> ctx) async {
  await Navigator.of(ctx.context).push(
      MaterialPageRoute(builder: (_) => ctx.buildComponent('createAddress')));
}
