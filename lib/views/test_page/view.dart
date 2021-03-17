import 'dart:io';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:movie/actions/api/base_api.dart';
import 'package:movie/models/enums/premium_type.dart';
import 'package:movie/models/models.dart';
import 'package:stripe_payment/stripe_payment.dart';

import 'state.dart';

Widget buildView(
    TestPageState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    backgroundColor: Color(0xFFF0F0F0),
    appBar: AppBar(
      backgroundColor: state.themeColor,
      title: Text('${state?.locale?.languageCode}'),
    ),
    body: Column(children: [
      SizedBox(
        height: 200,
        child: StreamBuilder<FetchResult>(
          stream: state.testData2,
          builder: (_, snapShot) {
            switch (snapShot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(child: Text('waiting'));
              case ConnectionState.active:
              case ConnectionState.done:
                print(snapShot.data);
                return Center(
                    child: Text(snapShot.data?.data?.toString() ?? ''));
              default:
                return Center(child: Text('waiting'));
            }
          },
        ),
      ),
      _StripeTest()
    ]),
  );
}

class _StripeTest extends StatefulWidget {
  @override
  _StripeTestState createState() => _StripeTestState();
}

class _StripeTestState extends State<_StripeTest> {
  @override
  void initState() {
    StripePayment.setStripeAccount('acct_1HlbgOKKzH6wLVHM');
    StripePayment.setOptions(StripeOptions(
        publishableKey:
            "pk_test_51HlbgOKKzH6wLVHMfSddwqGGnS4srIMaHKqqaXFnldELEoBczwcmCUmLf8o7PakDWDHfwcXoJE3a7WqBqNN4BWAL00CjwRpUNN",
        merchantId: "com.o1298098.movies",
        androidPayMode: 'test'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child:ElevatedButton(
        child: Text("Native payment"),
        onPressed: () async {
          await StripePayment.canMakeNativePayPayments([])
              .then((value) => print(value));
          if (Platform.isIOS) {
            //_controller.jumpTo(450);
          }
          StripePayment.paymentRequestWithNativePay(
            androidPayOptions: AndroidPayPaymentRequest(
              totalPrice: "1.20",
              currencyCode: "usd",
            ),
            applePayOptions: ApplePayPaymentOptions(
              countryCode: 'US',
              currencyCode: 'usd',
              items: [
                ApplePayItem(
                  label: 'Test',
                  amount: '13',
                )
              ],
            ),
          ).then((token) async {
            print(token.tokenId);
            final _result = await BaseApi.instance
                .createStripePremiumSubscription(
                    Purchase(
                        amount: 100,
                        deviceData: '',
                        paymentMethodNonce: token.tokenId,
                        userId: 'WaViBxaJwEbRIzc0Jx3K4RM4fr02'),
                    PremiumType.oneMonth);
            if (_result.success) {
              print(_result.result);
              StripePayment.completeNativePayRequest();
            } else
              StripePayment.cancelNativePayRequest();
          });
        },
      ),
    );
  }
}
