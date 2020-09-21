import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:movie/actions/api/base_api.dart';
import 'package:movie/actions/user_info_operate.dart';
import 'package:movie/models/base_api_model/payment_client_token.dart';
import 'package:movie/models/base_api_model/purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'action.dart';
import 'state.dart';

Effect<CheckOutPageState> buildEffect() {
  return combineEffects(<Object, Effect<CheckOutPageState>>{
    CheckOutPageAction.action: _onAction,
    CheckOutPageAction.selectPaymentMethod: _selectPaymentMethod,
    CheckOutPageAction.pay: _onPay,
  });
}

void _onAction(Action action, Context<CheckOutPageState> ctx) {}
Future _selectPaymentMethod(
    Action action, Context<CheckOutPageState> ctx) async {
  ctx.dispatch(CheckOutPageActionCreator.loading(true));
  PaymentClientToken _clientNonce =
      await _getToken(ctx.state.user.firebaseUser.uid);
  ctx.dispatch(CheckOutPageActionCreator.loading(false));
  if (_clientNonce?.token == null)
    return Toast.show('Something wrong', ctx.context,
        gravity: Toast.CENTER, duration: 5);
  final request = BraintreeDropInRequest(
    vaultManagerEnabled: true,
    clientToken: _clientNonce.token,
    collectDeviceData: true,
    venmoEnabled: true,
    maskCardNumber: true,
    maskSecurityCode: true,
    cardEnabled: true,
    googlePaymentRequest: BraintreeGooglePaymentRequest(
      totalPrice: ctx.state.checkoutData.amount.toString(),
      currencyCode: 'USD',
      billingAddressRequired: false,
    ),
    paypalRequest: BraintreePayPalRequest(
      amount: ctx.state.checkoutData.amount.toString(),
      displayName: 'Example company',
    ),
  );
  BraintreeDropInResult result = await BraintreeDropIn.start(request);
  if (result != null)
    ctx.dispatch(CheckOutPageActionCreator.updatePaymentMethod(result));
}

void _onPay(Action action, Context<CheckOutPageState> ctx) async {
  ctx.dispatch(CheckOutPageActionCreator.loading(true));
  if (ctx.state.user == null || ctx.state.braintreeDropInResult == null) {
    ctx.dispatch(CheckOutPageActionCreator.loading(false));
    return Toast.show('empty payment method', ctx.context,
        gravity: Toast.CENTER, duration: 5);
  }
  final _baseApi = BaseApi.instance;
  final _r = await _baseApi.createPremiumSubscription(
    Purchase(
      userId: ctx.state.user.firebaseUser.uid,
      amount: ctx.state.checkoutData.amount,
      paymentMethodNonce:
          ctx.state.braintreeDropInResult.paymentMethodNonce.nonce,
    ),
    ctx.state.checkoutData.premiumType,
  );
  ctx.dispatch(CheckOutPageActionCreator.loading(false));
  if (!_r.success)
    return Toast.show('Something wrong', ctx.context,
        gravity: Toast.CENTER, duration: 5);
  if (_r.result.status) {
    if (_r.result.data == null) return;
    if (_r.result.data.expireDate == null) return;
    UserInfoOperate.setPremium(_r.result.data);
    await Navigator.of(ctx.context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: Text('Payed'),
            ),
            body: Center(
              child: Container(
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Thank you!!!',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 40),
                      Text('Premium expire date: ${_r.result.data.expireDate}')
                    ]),
              ),
            ),
          ),
        ),
        (route) => route.isFirst);
  } else
    Toast.show(_r.message, ctx.context, gravity: Toast.CENTER, duration: 5);
  print(_r);
}

Future<PaymentClientToken> _getToken(String uid) async {
  PaymentClientToken _clientNonce = PaymentClientToken.fromParams(
      expiredTime: DateTime.now().millisecondsSinceEpoch);
  SharedPreferences preferences = await SharedPreferences.getInstance();
  final _token = preferences.getString('PaymentToken');
  if (_token != null) _clientNonce = PaymentClientToken(_token);
  if (_token == null || _clientNonce.isExpired()) {
    final _baseApi = BaseApi.instance;
    var r = await _baseApi.getPaymentToken(uid);
    if (r.success) {
      _clientNonce = PaymentClientToken.fromParams(
          token: r.result, expiredTime: DateTime.now().millisecondsSinceEpoch);
      preferences.setString('PaymentToken', _clientNonce.toString());
    } else
      _clientNonce = PaymentClientToken.fromParams(
          expiredTime: DateTime.now().millisecondsSinceEpoch);
  }
  return _clientNonce;
}
