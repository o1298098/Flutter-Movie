import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/actions/api/base_api.dart';
import 'package:movie/actions/user_info_operate.dart';
import 'package:movie/models/base_api_model/purchase.dart';
import 'package:movie/models/enums/premium_type.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:toast/toast.dart';
import 'action.dart';
import 'state.dart';

Effect<CheckOutPageState> buildEffect() {
  return combineEffects(<Object, Effect<CheckOutPageState>>{
    CheckOutPageAction.action: _onAction,
    CheckOutPageAction.selectPaymentMethod: _selectPaymentMethod,
    CheckOutPageAction.getCreditCards: _getCreditCards,
    CheckOutPageAction.pay: _onPay,
    Lifecycle.build: _onInit,
  });
}

void _onAction(Action action, Context<CheckOutPageState> ctx) {}
void _onInit(Action action, Context<CheckOutPageState> ctx) {
  StripePayment.setStripeAccount('acct_1HlbgOKKzH6wLVHM');
  StripePayment.setOptions(StripeOptions(
      publishableKey:
          "pk_test_51HlbgOKKzH6wLVHMfSddwqGGnS4srIMaHKqqaXFnldELEoBczwcmCUmLf8o7PakDWDHfwcXoJE3a7WqBqNN4BWAL00CjwRpUNN",
      merchantId: "com.o1298098.movies",
      androidPayMode: 'test'));
}

Future _selectPaymentMethod(
    Action action, Context<CheckOutPageState> ctx) async {
  await Navigator.of(ctx.context).push(
    PageRouteBuilder(
      barrierColor: const Color(0x55000000),
      fullscreenDialog: true,
      barrierDismissible: true,
      opaque: false,
      pageBuilder: (context, animation, subAnimation) {
        return SlideTransition(
          position: Tween<Offset>(begin: Offset(0, 1), end: Offset(0, 0))
              .animate(CurvedAnimation(parent: animation, curve: Curves.ease)),
          child: ctx.buildComponent('payment'),
        );
      },
    ),
  );
}

void _onPay(Action action, Context<CheckOutPageState> ctx) async {
  // ctx.dispatch(CheckOutPageActionCreator.loading(true));
  if (ctx.state.user == null ||
      (!ctx.state.paymentState.nativePay &&
          ctx.state.paymentState.selectedCard == null)) {
    ctx.dispatch(CheckOutPageActionCreator.loading(false));
    return Toast.show('empty payment method', ctx.context,
        gravity: Toast.CENTER, duration: 5);
  }
  await StripePayment.canMakeNativePayPayments([])
      .then((value) => print(value));
  StripePayment.paymentRequestWithNativePay(
    androidPayOptions: AndroidPayPaymentRequest(
      totalPrice: ctx.state.checkoutData.amount.toString(),
      currencyCode: "usd",
    ),
    applePayOptions: ApplePayPaymentOptions(
      countryCode: 'US',
      currencyCode: 'usd',
      items: [
        ApplePayItem(
          label: 'Test',
          amount: ctx.state.checkoutData.amount.toString(),
        )
      ],
    ),
  ).then((token) async {
    print(token.tokenId);
    final _result = await BaseApi.instance.createPayment(
        Purchase(
            amount: ctx.state.checkoutData.amount,
            deviceData: '',
            paymentMethodNonce: token.tokenId,
            userId: ctx.state.user.firebaseUser.uid),
        PremiumType.oneMonth,
        ctx.state.paymentState.nativePay);
    ctx.dispatch(CheckOutPageActionCreator.loading(false));

    if (_result.success) {
      if (_result.result.status) {
        if (_result.result.data == null) return;
        if (_result.result.data.expireDate == null) return;

        StripePayment.completeNativePayRequest();
        UserInfoOperate.setPremium(_result.result.data);
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
                          Text(
                              'Premium expire date: ${_result.result.data.expireDate}')
                        ]),
                  ),
                ),
              ),
            ),
            (route) => route.isFirst);
      } else
        Toast.show(_result.message, ctx.context,
            gravity: Toast.CENTER, duration: 5);
      print(_result.result);
    } else {
      Toast.show('Something wrong', ctx.context,
          gravity: Toast.CENTER, duration: 5);
      StripePayment.cancelNativePayRequest();
    }
  });
}

Future _getCreditCards(Action action, Context<CheckOutPageState> ctx) async {
  if (ctx.state.user.firebaseUser == null) return;
  final _result =
      await BaseApi.instance.getCreditCards(ctx.state.user.firebaseUser.uid);
  if (_result.success) print(_result.result);
  Navigator.of(ctx.context).pop();
}
