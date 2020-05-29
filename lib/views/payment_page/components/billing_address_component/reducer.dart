import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/braintree_billing_address.dart';

import 'action.dart';
import 'state.dart';

Reducer<BillingAddressState> buildReducer() {
  return asReducer(
    <Object, Reducer<BillingAddressState>>{
      BillingAddressAction.action: _onAction,
      BillingAddressAction.update: _onUpdate,
      BillingAddressAction.insert: _onInsert,
      BillingAddressAction.delete: _onDelete,
    },
  );
}

BillingAddressState _onAction(BillingAddressState state, Action action) {
  final BillingAddressState newState = state.clone();
  return newState;
}

BillingAddressState _onUpdate(BillingAddressState state, Action action) {
  final BillingAddress _address = action.payload;
  final BillingAddressState newState = state.clone();
  final _list = newState.addresses.map((e) {
    if (e.id == _address.id) return _address;
    return e;
  }).toList();
  newState.addresses = _list;
  return newState;
}

BillingAddressState _onInsert(BillingAddressState state, Action action) {
  final BillingAddress _address = action.payload;
  final BillingAddressState newState = state.clone();
  final _list = newState.addresses.map((e) => e).toList();
  _list.insert(0, _address);
  newState.addresses = _list;
  return newState;
}

BillingAddressState _onDelete(BillingAddressState state, Action action) {
  final BillingAddress _address = action.payload;
  final BillingAddressState newState = state.clone();
  final _list = newState.addresses.map((e) => e).toList();
  _list.remove(_address);
  newState.addresses = _list;
  return newState;
}
