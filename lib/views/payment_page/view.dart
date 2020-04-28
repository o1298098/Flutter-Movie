import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/models/base_api_model/transaction.dart';

import 'state.dart';

Widget buildView(
    PaymentPageState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppBar(),
    body: state.transactions == null
        ? SizedBox()
        : ListView.separated(
            separatorBuilder: (_, __) => SizedBox(height: Adapt.px(20)),
            itemCount: state.transactions.list.length,
            itemBuilder: (_, index) {
              final d = state.transactions.list[index];
              return _ListCell(
                transaction: d,
              );
            },
          ),
  );
}

class _ListCell extends StatelessWidget {
  final Transaction transaction;
  const _ListCell({this.transaction});
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(transaction.createdAt),
          Row(
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
              Text(d ?? '')
            ],
          ),
          Text(transaction.amount.toString())
        ],
      ),
    );
  }
}
