import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/models/base_api_model/braintree_transaction.dart';
import 'package:movie/style/themestyle.dart';

import 'state.dart';

Widget buildView(
    HistoryState state, Dispatch dispatch, ViewService viewService) {
  final _theme = ThemeStyle.getTheme(viewService.context);
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
        padding: EdgeInsets.only(top: Adapt.px(80)),
        decoration: BoxDecoration(
            color: _theme.backgroundColor,
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(Adapt.px(60)))),
        child: ListView.separated(
            itemBuilder: (_, index) => _TransactionCell(
                  data: state.transactions?.list[index],
                ),
            separatorBuilder: (_, __) => SizedBox(height: Adapt.px(20)),
            itemCount: state.transactions?.list?.length ?? 0)),
  );
}

class _TransactionCell extends StatelessWidget {
  final Transaction data;
  const _TransactionCell({this.data});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Adapt.px(150),
      padding: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
      //color: const Color(0xFFF0E0C0),
      child: Row(
        children: [
          Container(
            width: Adapt.px(80),
            height: Adapt.px(80),
            decoration: BoxDecoration(
              color: const Color(0xFFA0C0F0),
              borderRadius: BorderRadius.circular(Adapt.px(20)),
            ),
            child: Icon(
              FontAwesomeIcons.paypal,
              color: const Color(0xFFFFFFFF),
              size: Adapt.px(30),
            ),
          ),
          SizedBox(width: Adapt.px(40)),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('**** **** **** 4444'),
                Text(
                  'May 20,2020',
                  style: TextStyle(
                      color: const Color(0xFF9E9E9E), fontSize: Adapt.px(20)),
                )
              ])
        ],
      ),
    );
  }
}
