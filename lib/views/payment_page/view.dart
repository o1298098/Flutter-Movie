import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/models/base_api_model/braintree_customer.dart';
import 'package:movie/models/base_api_model/transaction.dart';
import 'package:movie/style/themestyle.dart';
import 'package:shimmer/shimmer.dart';

import 'state.dart';

Widget buildView(
    PaymentPageState state, Dispatch dispatch, ViewService viewService) {
  final _theme = ThemeStyle.getTheme(viewService.context);
  return Scaffold(
    backgroundColor: _theme.backgroundColor,
    appBar: AppBar(
      iconTheme: _theme.iconTheme,
      brightness: _theme.brightness,
      backgroundColor: _theme.backgroundColor,
      elevation: 0.0,
      actions: [
        PopupMenuButton<String>(
          padding: EdgeInsets.zero,
          offset: Offset(0, Adapt.px(100)),
          icon: Icon(
            Icons.more_vert,
            color: _theme.iconTheme.color,
            size: Adapt.px(50),
          ),
          onSelected: (selected) {},
          itemBuilder: (ctx) {
            return [
              PopupMenuItem<String>(
                  value: 'BillAddress',
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.format_align_justify,
                      ),
                      SizedBox(width: 10),
                      Text('BillAddress')
                    ],
                  )),
            ];
          },
        )
      ],
      title: Text(
        'Wallet',
        style: TextStyle(color: _theme.textTheme.bodyText1.color),
      ),
    ),
    body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: Adapt.px(50)),
        child: const Text(
          'My Cards',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      _PaymentMethodList(paymentMethods: state.customer?.paymentMethods),
      Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Adapt.px(50), vertical: Adapt.px(20)),
        child: const Text(
          'Transactions',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      _TransactionList(transactions: state.transactions?.list),
    ]),
  );
}

class _TransactionCell extends StatelessWidget {
  final Transaction transaction;
  const _TransactionCell({this.transaction});
  @override
  Widget build(BuildContext context) {
    String imageUrl = '';
    String d = '';

    if (transaction.androidPayDetails != null) {
      imageUrl = transaction.androidPayDetails.imageUrl;
      d = transaction.androidPayDetails.sourceDescription;
    } else if (transaction.payPalDetails != null) {
      imageUrl = transaction.payPalDetails.imageUrl;
      d = transaction.payPalDetails.payerEmail;
    } else if (transaction.creditCard.token != null) {
      imageUrl = transaction.creditCard.imageUrl;
      d = transaction.creditCard.maskedNumber;
    }

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Adapt.px(20), vertical: Adapt.px(20)),
      decoration: BoxDecoration(
        color: const Color(0xFFEFEFEF),
        borderRadius: BorderRadius.circular(
          Adapt.px(10),
        ),
      ),
      child: Row(
        children: [
          Container(
            height: Adapt.px(50),
            width: Adapt.px(80),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(imageUrl),
              ),
            ),
          ),
          SizedBox(width: Adapt.px(20)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  width: Adapt.px(350),
                  child: Text(
                    d ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )),
              SizedBox(height: Adapt.px(6)),
              Text(
                DateFormat.yMMMd()
                    .format(DateTime.parse(transaction.createdAt)),
                style: TextStyle(
                    fontSize: Adapt.px(20), color: const Color(0xFF9E9E9E)),
              ),
            ],
          ),
          Expanded(child: SizedBox()),
          Text('-\$ ${transaction.amount.toString()}',
              style: TextStyle(fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}

class _TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  const _TransactionList({this.transactions});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: transactions == null
          ? _TransactionListShimmer()
          : ListView.separated(
              padding: EdgeInsets.symmetric(
                  horizontal: Adapt.px(50), vertical: Adapt.px(30)),
              shrinkWrap: true,
              separatorBuilder: (_, __) => SizedBox(height: Adapt.px(20)),
              itemCount: transactions.length,
              itemBuilder: (_, index) {
                final d = transactions[index];
                return _TransactionCell(
                  transaction: d,
                );
              },
            ),
    );
  }
}

class _CreditCardCell extends StatelessWidget {
  final PaymentMethod data;
  const _CreditCardCell({this.data});
  @override
  Widget build(BuildContext context) {
    final _creditCardColor = {
      'Visa': const Color(0xFFDEDEDE),
      'JCB': const Color(0xFFE3d2c2),
      'Discover': const Color(0xFF55E2A2),
      'MasterCard': const Color(0xFF556677),
    };
    return Container(
      width: Adapt.px(300),
      padding: EdgeInsets.all(Adapt.px(30)),
      decoration: BoxDecoration(
        color: _creditCardColor[data?.cardType?.value],
        borderRadius: BorderRadius.circular(Adapt.px(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${'**** **** **** ${data.lastFour}'}',
            style: TextStyle(
              fontSize: Adapt.px(24),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: Adapt.px(20)),
          Text(
            'Month/Year',
            style: TextStyle(fontSize: Adapt.px(18)),
          ),
          Text(data.expirationDate ?? ''),
          Text(data?.cardType?.value ?? ''),
          SizedBox(height: Adapt.px(20)),
          Container(
            height: Adapt.px(50),
            width: Adapt.px(80),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(data.imageUrl),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PaypalCell extends StatelessWidget {
  final PaymentMethod data;
  const _PaypalCell({this.data});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Adapt.px(300),
      padding: EdgeInsets.all(Adapt.px(30)),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(Adapt.px(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${data.email}'),
          SizedBox(height: Adapt.px(20)),
          Container(
            height: Adapt.px(50),
            width: Adapt.px(80),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(data.imageUrl),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentMethodList extends StatelessWidget {
  final List<PaymentMethod> paymentMethods;
  const _PaymentMethodList({this.paymentMethods});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Adapt.px(400),
      child: paymentMethods == null
          ? _PaymentMethodListShimmer()
          : ListView.separated(
              padding: EdgeInsets.symmetric(
                  horizontal: Adapt.px(50), vertical: Adapt.px(30)),
              scrollDirection: Axis.horizontal,
              separatorBuilder: (_, __) => SizedBox(width: Adapt.px(50)),
              itemCount: paymentMethods.length + 1,
              itemBuilder: (_, index) {
                if (index == 0)
                  return Container(
                    width: Adapt.px(80),
                    height: Adapt.px(80),
                    margin: EdgeInsets.only(bottom: Adapt.px(260)),
                    decoration: BoxDecoration(
                      color: Color(0xFF404040),
                      borderRadius: BorderRadius.circular(Adapt.px(20)),
                    ),
                    child: Icon(Icons.add, color: const Color(0xFFFFFFFF)),
                  );
                final _d = paymentMethods[index - 1];
                return _d.cardType != null
                    ? _CreditCardCell(data: _d)
                    : _PaypalCell(data: _d);
              },
            ),
    );
  }
}

class _PaymentMethodListShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    return Shimmer.fromColors(
        baseColor: _theme.primaryColorDark,
        highlightColor: _theme.primaryColorLight,
        child: ListView.separated(
          padding: EdgeInsets.symmetric(
              horizontal: Adapt.px(50), vertical: Adapt.px(30)),
          scrollDirection: Axis.horizontal,
          separatorBuilder: (_, __) => SizedBox(width: Adapt.px(50)),
          itemCount: 3,
          itemBuilder: (_, index) {
            if (index == 0)
              return Container(
                width: Adapt.px(80),
                height: Adapt.px(80),
                margin: EdgeInsets.only(bottom: Adapt.px(260)),
                decoration: BoxDecoration(
                  color: Color(0xFF404040),
                  borderRadius: BorderRadius.circular(Adapt.px(20)),
                ),
                child: Icon(Icons.add, color: const Color(0xFFFFFFFF)),
              );
            return Container(
                width: Adapt.px(300),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(Adapt.px(20)),
                ));
          },
        ));
  }
}

class _TransactionListShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    return Shimmer.fromColors(
        baseColor: _theme.primaryColorDark,
        highlightColor: _theme.primaryColorLight,
        child: ListView.separated(
          padding: EdgeInsets.symmetric(
              horizontal: Adapt.px(50), vertical: Adapt.px(30)),
          shrinkWrap: true,
          separatorBuilder: (_, __) => SizedBox(height: Adapt.px(20)),
          itemCount: 8,
          itemBuilder: (_, index) {
            return Container(
                height: Adapt.px(100),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFEFEF),
                  borderRadius: BorderRadius.circular(
                    Adapt.px(10),
                  ),
                ));
          },
        ));
  }
}
