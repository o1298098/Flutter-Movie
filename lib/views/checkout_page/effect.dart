import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:movie/actions/base_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'action.dart';
import 'state.dart';

Effect<CheckOutPageState> buildEffect() {
  return combineEffects(<Object, Effect<CheckOutPageState>>{
    CheckOutPageAction.action: _onAction,
    CheckOutPageAction.selectPaymentMethod: _selectPaymentMethod
  });
}

void _onAction(Action action, Context<CheckOutPageState> ctx) {}
Future _selectPaymentMethod(
    Action action, Context<CheckOutPageState> ctx) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String _clientNonce = preferences.getString('PaymentToken');
  if (_clientNonce == null) {
    var r = await BaseApi.getPaymentToken(ctx.state.user.uid);
    if (r != null) _clientNonce = r;
    preferences.setString('PaymentToken', r);
  }
  final request = BraintreeDropInRequest(
    vaultManagerEnabled: true,
    clientToken: _clientNonce,
    collectDeviceData: true,
    venmoEnabled: true,
    maskCardNumber: true,
    maskSecurityCode: true,
    cardEnabled: true,
    googlePaymentRequest: BraintreeGooglePaymentRequest(
      totalPrice: '4.20',
      currencyCode: 'USD',
      billingAddressRequired: false,
    ),
    paypalRequest: BraintreePayPalRequest(
      amount: '4.20',
      displayName: 'Example company',
    ),
  );
  BraintreeDropInResult result = await BraintreeDropIn.start(request);
  if (result != null)
    ctx.dispatch(CheckOutPageActionCreator.updatePaymentMethod(result));
}
