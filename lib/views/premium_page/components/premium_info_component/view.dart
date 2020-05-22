import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/models/app_user.dart';
import 'package:movie/models/base_api_model/braintree_subscription.dart';
import 'package:movie/models/base_api_model/user_premium_model.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/models/base_api_model/braintree_transaction.dart';

import 'state.dart';

Widget buildView(
    PremiumInfoState state, Dispatch dispatch, ViewService viewService) {
  final _theme = ThemeStyle.getTheme(viewService.context);
  return Container(
    color: _theme.brightness == Brightness.light
        ? const Color(0xFFF0F0F0)
        : const Color(0xFF505050),
    child: Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: Adapt.padTopH()),
          padding: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
          height: Adapt.px(300),
          child: Stack(
            children: [
              _HeaderInfo(user: state.user),
              GestureDetector(
                onTap: () => Navigator.of(viewService.context).pop(),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.close,
                    color: Colors.grey,
                  ),
                ),
              )
            ],
          ),
        ),
        _Body(subscription: state.subscription)
      ],
    ),
  );
}

class _HeaderInfo extends StatelessWidget {
  final AppUser user;
  const _HeaderInfo({this.user});
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: Adapt.px(180),
          height: Adapt.px(180),
          decoration: BoxDecoration(
            color: const Color(0xFF9E92E1),
            borderRadius: BorderRadius.circular(
              Adapt.px(20),
            ),
          ),
          child: Center(
            child: const Text(
              'logo',
              style: TextStyle(
                color: const Color(0xFFFFFFFF),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
        SizedBox(width: Adapt.px(40)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Premium',
              style: TextStyle(
                  color: const Color(0xFF9E9E9E), fontSize: Adapt.px(28)),
            ),
            SizedBox(height: Adapt.px(8)),
            Text(
              '\$6.99 / 6 months',
              style: TextStyle(
                  fontSize: Adapt.px(35), fontWeight: FontWeight.bold),
            ),
            SizedBox(height: Adapt.px(15)),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text: 'Next payment ',
                      style: TextStyle(
                        color: const Color(0xFF9E9E9E),
                      )),
                  TextSpan(
                      text: DateFormat.yMMMd().format(
                          DateTime.parse(user.premium.expireDate)
                              .add(Duration(days: 1))),
                      style: TextStyle(fontWeight: FontWeight.bold))
                ],
              ),
            ),
            SizedBox(height: Adapt.px(8)),
            _LinearProgressIndicator(
              premiumData: user.premium,
            ),
            SizedBox(height: Adapt.px(5)),
            SizedBox(
              width: Adapt.px(400),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat.MMMd()
                        .format(DateTime.parse(user.premium.startDate)),
                    style: TextStyle(
                      color: const Color(0xFFA0A0A0),
                      fontSize: Adapt.px(20),
                    ),
                  ),
                  Text(
                    DateFormat.MMMd()
                        .format(DateTime.parse(user.premium.expireDate)),
                    style: TextStyle(
                        color: const Color(0xFFA0A0A0), fontSize: Adapt.px(20)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _LinearProgressIndicator extends StatelessWidget {
  final UserPremiumData premiumData;
  const _LinearProgressIndicator({this.premiumData});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    final _total =
        DateTime.parse(premiumData.expireDate).millisecondsSinceEpoch -
            DateTime.parse(premiumData.startDate).millisecondsSinceEpoch;
    final _value =
        DateTime.now().add(Duration(hours: 2)).millisecondsSinceEpoch -
            DateTime.parse(premiumData.startDate).millisecondsSinceEpoch;
    return Container(
      width: Adapt.px(400),
      height: Adapt.px(22),
      padding: EdgeInsets.all(Adapt.px(6)),
      decoration: BoxDecoration(
          color: _theme.brightness == Brightness.light
              ? const Color(0xFFE0E0E0)
              : const Color(0xFF606060),
          borderRadius: BorderRadius.circular(Adapt.px(11))),
      child: Row(children: [
        Container(
          width: (_value / _total) * Adapt.px(390),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.purple[200],
              Colors.purple[100],
            ]),
            borderRadius: BorderRadius.circular(
              Adapt.px(7.5),
            ),
          ),
        )
      ]),
    );
  }
}

class _Body extends StatelessWidget {
  final BraintreeSubscription subscription;
  const _Body({this.subscription});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    return Expanded(
      child: Container(
        width: Adapt.screenW(),
        padding: EdgeInsets.symmetric(
            horizontal: Adapt.px(50), vertical: Adapt.px(50)),
        decoration: BoxDecoration(
          color: _theme.backgroundColor,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(Adapt.px(60)),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Adapt.px(30)),
            Text(
              'Payment Method',
              style: TextStyle(
                  fontSize: Adapt.px(35), fontWeight: FontWeight.w500),
            ),
            SizedBox(height: Adapt.px(30)),
            _PaymentMethodCell(
              transaction: subscription?.transactions?.last,
            ),
            SizedBox(height: Adapt.px(30)),
            Padding(
              padding: EdgeInsets.symmetric(vertical: Adapt.px(50)),
              child: Row(
                children: [
                  Text(
                    'Subscribe',
                    style: TextStyle(
                        fontSize: Adapt.px(35), fontWeight: FontWeight.w500),
                  ),
                  Expanded(child: SizedBox()),
                  CupertinoSwitch(value: true, onChanged: (e) {}),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: Adapt.px(50)),
              child: Row(
                children: [
                  Text(
                    'Bill',
                    style: TextStyle(
                        fontSize: Adapt.px(35), fontWeight: FontWeight.w500),
                  ),
                  Expanded(child: SizedBox()),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: const Color(0xFF9E9E9E),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: Adapt.px(50)),
              child: Row(
                children: [
                  Text(
                    'Change Plan',
                    style: TextStyle(
                        fontSize: Adapt.px(35), fontWeight: FontWeight.w500),
                  ),
                  Expanded(child: SizedBox()),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: const Color(0xFF9E9E9E),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PaymentMethodCell extends StatelessWidget {
  final Transaction transaction;

  const _PaymentMethodCell({this.transaction});
  @override
  Widget build(BuildContext context) {
    final _creditCardTheme = {
      'Visa': ['images/visa_logo.png', const Color(0xFF9E92E1)],
      'JCB': ['images/visa_logo.png', const Color(0xFFE3d2c2)],
      'Discover': ['images/visa_logo.png', const Color(0XFF66AA9E)],
      'MasterCard': ['images/visa_logo.png', const Color(0xFF556677)],
      '-': ['images/visa_logo.png', const Color(0xFF556677)],
    };
    final Color _cardColor =
        _creditCardTheme[transaction?.creditCard?.cardType?.value ?? '-'][1];
    return Container(
      width: Adapt.screenW(),
      height: Adapt.px(380),
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Adapt.px(30)),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                _cardColor.withAlpha(100),
                _cardColor.withAlpha(200),
                _cardColor,
              ])),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              constraints: BoxConstraints(maxWidth: Adapt.px(150)),
              height: Adapt.px(50),
              child: Image.asset(
                'images/visa_logo.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(height: Adapt.px(50)),
          Container(
            height: Adapt.px(40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('****',
                    style: TextStyle(
                      color: const Color(0xFFFFFFFF),
                      fontSize: Adapt.px(35),
                    )),
                Text('****',
                    style: TextStyle(
                      color: const Color(0xFFFFFFFF),
                      fontSize: Adapt.px(35),
                    )),
                Text('****',
                    style: TextStyle(
                      color: const Color(0xFFFFFFFF),
                      fontSize: Adapt.px(35),
                    )),
                Text(
                  '${transaction?.creditCard?.lastFour ?? '****'}',
                  style: TextStyle(
                    color: const Color(0xFFFFFFFF),
                    fontSize: Adapt.px(35),
                  ),
                )
              ],
            ),
          ),
          Expanded(child: SizedBox()),
          Text(
            'Expires',
            style: TextStyle(color: Color(0xFFE0E0E0)),
          ),
          const SizedBox(height: 2),
          Text(
            transaction?.creditCard?.expirationDate ?? 'MM/yyyy',
            style: TextStyle(color: Color(0xFFFFFFFF)),
          )
        ],
      ),
    );
  }
}
