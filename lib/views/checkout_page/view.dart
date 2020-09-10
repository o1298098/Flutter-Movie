import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/style/themestyle.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    CheckOutPageState state, Dispatch dispatch, ViewService viewService) {
  return Builder(builder: (context) {
    final _theme = ThemeStyle.getTheme(context);

    return Stack(
      children: [
        Scaffold(
          backgroundColor: _theme.backgroundColor,
          appBar: AppBar(
            brightness: _theme.brightness,
            backgroundColor: _theme.backgroundColor,
            iconTheme: _theme.iconTheme,
            elevation: 0.0,
            title: Text('Check Out',
                style: TextStyle(color: _theme.textTheme.bodyText1.color)),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Adapt.px(20)),
                _DetailCell(
                  name: state.checkoutData?.name ?? '',
                  amount: state.checkoutData?.amount ?? 0.0,
                ),
                Expanded(child: SizedBox()),
                _TotalCell(amount: state.checkoutData?.amount ?? 0.0),
                SizedBox(height: Adapt.px(30)),
                _PaymentCell(
                  braintreeDropInResult: state.braintreeDropInResult,
                  onTap: () =>
                      dispatch(CheckOutPageActionCreator.selectPaymentMethod()),
                ),
                SizedBox(height: Adapt.px(30)),
                _PayButton(
                  onTap: () => dispatch(CheckOutPageActionCreator.onPay()),
                ),
                SizedBox(height: Adapt.px(50))
              ],
            ),
          ),
        ),
        state.loading ? _LoadingLayout() : SizedBox(),
      ],
    );
  });
}

class _DetailCell extends StatelessWidget {
  final String name;
  final double amount;
  const _DetailCell({this.name, this.amount});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    final _boxShadow = [
      BoxShadow(
          color: _theme.brightness == Brightness.light
              ? Color(0xFFD0D0D0)
              : Color(0xFF202020),
          blurRadius: Adapt.px(10),
          offset: Offset(Adapt.px(5), Adapt.px(5)))
    ];
    return Container(
      padding: EdgeInsets.all(Adapt.px(30)),
      width: Adapt.screenW(),
      constraints: BoxConstraints(minHeight: Adapt.px(400)),
      decoration: BoxDecoration(
        color: _theme.backgroundColor,
        boxShadow: _boxShadow,
        borderRadius: BorderRadius.circular(
          Adapt.px(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Detail',
            style: TextStyle(
              fontSize: Adapt.px(30),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: Adapt.px(50)),
          Row(children: [
            Container(
              width: Adapt.px(60),
              height: Adapt.px(60),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xFF505050)),
            ),
            SizedBox(width: Adapt.px(30)),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                name,
                style: TextStyle(fontSize: Adapt.px(30)),
              ),
              Text(
                '\$ ${amount.toString()}',
                style: TextStyle(fontSize: Adapt.px(30)),
              )
            ])
          ])
        ],
      ),
    );
  }
}

class _TotalCell extends StatelessWidget {
  final double amount;
  const _TotalCell({this.amount});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    final _boxShadow = [
      BoxShadow(
          color: _theme.brightness == Brightness.light
              ? Color(0xFFD0D0D0)
              : Color(0xFF202020),
          blurRadius: Adapt.px(10),
          offset: Offset(Adapt.px(5), Adapt.px(5)))
    ];
    return Container(
      padding: EdgeInsets.all(Adapt.px(30)),
      decoration: BoxDecoration(
          color: _theme.backgroundColor,
          boxShadow: _boxShadow,
          borderRadius: BorderRadius.circular(Adapt.px(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total',
            style: TextStyle(
              fontSize: Adapt.px(28),
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '\$ ${amount.toString()}',
            style: TextStyle(
              fontSize: Adapt.px(28),
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}

final Map<String, String> _paymentType = {
  'none': '',
  'PayPal': 'images/paypal_account.png',
  'Visa': 'images/visa.png',
  'MasterCard': 'images/mastercard.png',
  'Discover': 'images/discover.png',
  'JCB': 'images/jcb.png',
  'Google Pay': 'images/google.png'
};

class _PaymentCell extends StatelessWidget {
  final Function onTap;
  final BraintreeDropInResult braintreeDropInResult;
  const _PaymentCell({this.braintreeDropInResult, this.onTap});

  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    final _boxShadow = [
      BoxShadow(
          color: _theme.brightness == Brightness.light
              ? const Color(0xFFD0D0D0)
              : const Color(0xFF202020),
          blurRadius: Adapt.px(10),
          offset: Offset(Adapt.px(5), Adapt.px(5)))
    ];
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(Adapt.px(30)),
        decoration: BoxDecoration(
            color: _theme.backgroundColor,
            boxShadow: _boxShadow,
            borderRadius: BorderRadius.circular(Adapt.px(20))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Select Payment Method',
            style: TextStyle(
              fontSize: Adapt.px(28),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: Adapt.px(20)),
          Row(
            children: [
              braintreeDropInResult == null
                  ? SizedBox(height: Adapt.px(50))
                  : Image.asset(
                      _paymentType[braintreeDropInResult
                              ?.paymentMethodNonce?.typeLabel ??
                          'none'],
                      height: Adapt.px(50),
                    ),
              SizedBox(width: Adapt.px(20)),
              SizedBox(
                width: Adapt.px(500),
                child: Text(
                  '${braintreeDropInResult?.paymentMethodNonce?.description ?? '---'}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          )
        ]),
      ),
    );
  }
}

class _PayButton extends StatelessWidget {
  final Function onTap;
  const _PayButton({this.onTap});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    final _boxShadow = [
      BoxShadow(
          color: _theme.brightness == Brightness.light
              ? Color(0xFFD0D0D0)
              : Color(0xFF202020),
          blurRadius: Adapt.px(10),
          offset: Offset(Adapt.px(5), Adapt.px(5)))
    ];
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Adapt.screenW(),
        height: Adapt.px(90),
        decoration: BoxDecoration(
            color: const Color(0xDD000000),
            boxShadow: _boxShadow,
            borderRadius: BorderRadius.circular(Adapt.px(20))),
        child: Center(
            child: Text(
          'Pay',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: Adapt.px(35),
            fontWeight: FontWeight.bold,
          ),
        )),
      ),
    );
  }
}

class _LoadingLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: Container(
          width: Adapt.screenW(),
          height: Adapt.screenH(),
          color: const Color(0x20000000),
          child: Center(
            child: Container(
              width: Adapt.px(300),
              height: Adapt.px(300),
              decoration: BoxDecoration(
                color: const Color(0xAA000000),
                borderRadius: BorderRadius.circular(
                  Adapt.px(20),
                ),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation(const Color(0xFFFFFFFF)),
                    ),
                    SizedBox(height: Adapt.px(30)),
                    const Text(
                      'Working',
                      style: TextStyle(
                        color: const Color(0xFFFFFFFF),
                        fontSize: 14,
                      ),
                    )
                  ]),
            ),
          ),
        ));
  }
}
