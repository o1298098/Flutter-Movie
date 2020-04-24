import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    CheckOutPageState state, Dispatch dispatch, ViewService viewService) {
  Widget _buildIcon(String type) {
    String _urlPath;
    switch (type) {
      case 'PayPal':
        _urlPath = 'images/paypal_account.png';
        break;
      case 'Visa':
        _urlPath = 'images/visa.png';
        break;
    }
    return Image.asset(
      _urlPath,
      height: Adapt.px(50),
    );
  }

  return Scaffold(
    appBar: AppBar(),
    body: Padding(
      padding: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          state.checkoutData.name,
          style: TextStyle(fontSize: Adapt.px(40)),
        ),
        Text(
          state.checkoutData.amount.toString(),
          style: TextStyle(fontSize: Adapt.px(40)),
        ),
        Expanded(child: SizedBox()),
        GestureDetector(
          onTap: () =>
              dispatch(CheckOutPageActionCreator.selectPaymentMethod()),
          child: Container(
            padding: EdgeInsets.all(Adapt.px(30)),
            decoration: BoxDecoration(color: Colors.amber[200]),
            child: Row(
              children: [
                Text('select payment method'),
                Expanded(child: SizedBox()),
                state.braintreeDropInResult == null
                    ? SizedBox(height: Adapt.px(50))
                    : _buildIcon(state.braintreeDropInResult?.paymentMethodNonce
                            ?.typeLabel ??
                        '')
              ],
            ),
          ),
        ),
        Container(
          width: Adapt.px(500),
          child: RaisedButton(
            onPressed: () {},
            child: Text('Purchase'),
          ),
        ),
        SizedBox(height: Adapt.px(50))
      ]),
    ),
  );
}
