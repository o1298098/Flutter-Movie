import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/models/base_api_model/braintree_transaction.dart';
import 'package:movie/style/themestyle.dart';

import 'state.dart';

Widget buildView(
    HistoryState state, Dispatch dispatch, ViewService viewService) {
  return Builder(
    builder: (context) {
      final _theme = ThemeStyle.getTheme(context);
      return Scaffold(
        backgroundColor: _theme.primaryColorDark,
        appBar: AppBar(
          backgroundColor: _theme.primaryColorDark,
          brightness: _theme.brightness,
          iconTheme: _theme.iconTheme,
          elevation: 0.0,
          centerTitle: false,
          title: Text('Payment History',
              style: TextStyle(color: _theme.textTheme.bodyText1.color)),
        ),
        body: Container(
          margin: EdgeInsets.only(top: Adapt.px(20)),
          decoration: BoxDecoration(
            color: _theme.backgroundColor,
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(Adapt.px(60))),
          ),
          child: Column(
            children: [
              Expanded(
                child: state.loading
                    ? Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation(_theme.iconTheme.color),
                        ),
                      )
                    : (state.transactions?.list?.length ?? 0) > 0
                        ? ListView.separated(
                            padding: EdgeInsets.symmetric(
                                horizontal: Adapt.px(40),
                                vertical: Adapt.px(40)),
                            itemBuilder: (_, index) => _TransactionCell(
                                data: state.transactions?.list[index]),
                            separatorBuilder: (_, __) =>
                                SizedBox(height: Adapt.px(20)),
                            itemCount: state.transactions?.list?.length ?? 0)
                        : const Center(
                            child: const Text(
                              'Empty List',
                              style: TextStyle(
                                  color: const Color(0xFF9E9E9E), fontSize: 16),
                            ),
                          ),
              )
            ],
          ),
        ),
      );
    },
  );
}

class _TransactionCell extends StatelessWidget {
  final Transaction data;
  const _TransactionCell({this.data});
  @override
  Widget build(BuildContext context) {
    final _icons = {
      'Visa': [FontAwesomeIcons.ccVisa, const Color(0xFFAABBFF)],
      'JCB': [FontAwesomeIcons.ccJcb, const Color(0xFFAADDDD)],
      'Discover': [FontAwesomeIcons.ccDiscover, const Color(0xFFBBCCDD)],
      'MasterCard': [FontAwesomeIcons.ccMastercard, const Color(0xFF306080)],
      'PayPal': [FontAwesomeIcons.paypal, const Color(0xFF20A5F0)],
      'GooglePay': [FontAwesomeIcons.google, const Color(0xFF506070)],
      'ApplePay': [FontAwesomeIcons.applePay, const Color(0xFF505050)],
      '-': [FontAwesomeIcons.carCrash, const Color(0xFF000000)]
    };
    String name;
    String type = '-';
    if (data.creditCard.lastFour != null) {
      name = '**** **** **** ${data.creditCard.lastFour}';
      type = data.creditCard.cardType.value;
    } else if (data.payPalDetails != null) {
      name = data.payPalDetails.payerEmail;
      type = 'PayPal';
    } else if (data.androidPayDetails != null) {
      name = '**** **** **** ${data.androidPayDetails.last4}';
      type = 'GooglePay';
    } else if (data.androidPayDetails != null) {
      name = '**** **** **** ${data.androidPayDetails.last4}';
      type = 'GooglePay';
    }
    return Container(
      height: Adapt.px(150),
      //color: const Color(0xFFF0E0C0),
      child: Row(
        children: [
          Container(
            width: Adapt.px(80),
            height: Adapt.px(80),
            decoration: BoxDecoration(
              color: _icons[type][1],
              borderRadius: BorderRadius.circular(Adapt.px(20)),
            ),
            child: Icon(
              _icons[type][0],
              color: const Color(0xFFFFFFFF),
              size: Adapt.px(30),
            ),
          ),
          SizedBox(width: Adapt.px(40)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: Adapt.screenW() - Adapt.px(300),
                child: Text(name ?? '-'),
              ),
              Text(
                DateFormat.yMMMd().format(DateTime.parse(data.createdAt)),
                style: TextStyle(
                    color: const Color(0xFF9E9E9E), fontSize: Adapt.px(20)),
              ),
            ],
          ),
          Expanded(child: SizedBox()),
          Text('\$${data.amount}')
        ],
      ),
    );
  }
}
