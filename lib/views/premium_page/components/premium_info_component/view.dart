import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/models/app_user.dart';
import 'package:movie/models/base_api_model/braintree_creditcard.dart';
import 'package:movie/models/base_api_model/braintree_subscription.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/models/base_api_model/braintree_transaction.dart';
import 'package:movie/views/premium_page/action.dart';

import 'state.dart';

Widget buildView(
    PremiumInfoState state, Dispatch dispatch, ViewService viewService) {
  return Builder(builder: (context) {
    final _theme = ThemeStyle.getTheme(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: _theme.brightness == Brightness.light
            ? SystemUiOverlayStyle.dark
            : SystemUiOverlayStyle.light,
        child: Container(
          color: _theme.brightness == Brightness.light
              ? const Color(0xFFF0F0F0)
              : const Color(0xFF505050),
          child: Column(
            children: [
              viewService.buildComponent('header'),
              _Body(
                subscription: state.subscription,
                user: state.user,
                dispatch: dispatch,
              )
            ],
          ),
        ));
  });
}

class _Body extends StatelessWidget {
  final BraintreeSubscription subscription;
  final AppUser user;
  final Dispatch dispatch;
  const _Body({this.subscription, this.user, this.dispatch});
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
            Row(children: [
              Text(
                'Payment Method',
                style: TextStyle(
                    fontSize: Adapt.px(35), fontWeight: FontWeight.w500),
              )
            ]),
            SizedBox(height: Adapt.px(30)),
            _PaymentMethodCell(
                transaction: subscription?.transactions != null &&
                        (subscription?.transactions?.length ?? 0) > 0
                    ? subscription.transactions.last
                    : null),
            SizedBox(height: Adapt.px(30)),
            /* Padding(
              padding: EdgeInsets.symmetric(vertical: Adapt.px(50)),
              child: Row(
                children: [
                  Text(
                    'Subscribe',
                    style: TextStyle(
                        fontSize: Adapt.px(35), fontWeight: FontWeight.w500),
                  ),
                  Expanded(child: SizedBox()),
                  CupertinoSwitch(
                      value: user.premium.subscription, onChanged: (e) {}),
                ],
              ),
            ),*/
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
            InkWell(
              onTap: () => dispatch(PremiumPageActionCreator.changePlan()),
              child: Padding(
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
    Widget _child;

    if (transaction == null)
      _child = _PaymentMethodShimmer();
    else if (transaction.creditCard?.lastFour != null)
      _child = _CreditCardCell(creditCard: transaction.creditCard);
    else if (transaction.payPalDetails != null)
      _child = _PayPalCell(details: transaction.payPalDetails);
    else
      _child = _PaymentMethodShimmer();

    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: _child,
    );
  }
}

class _CreditCardCell extends StatelessWidget {
  final CreditCard creditCard;
  const _CreditCardCell({this.creditCard});

  @override
  Widget build(BuildContext context) {
    final _creditCardTheme = {
      'Visa': ['images/visa_logo.png', const Color(0xFF9E92E1)],
      'JCB': ['images/jcb_logo.png', const Color(0xFFE3d2c2)],
      'Discover': ['images/discover_logo.png', const Color(0XFF66AA9E)],
      'MasterCard': ['images/mastercard_logo.png', const Color(0xFF556677)],
      '-': ['images/visa_logo.png', const Color(0xFF556677)],
    };
    final Color _cardColor =
        _creditCardTheme[creditCard?.cardType?.value ?? '-'][1];

    final TextStyle _textStyle = TextStyle(
      color: const Color(0xFFFFFFFF),
      fontSize: Adapt.px(35),
    );

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
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              constraints: BoxConstraints(maxWidth: Adapt.px(150)),
              height: Adapt.px(50),
              child: Image.asset(
                _creditCardTheme[creditCard?.cardType?.value ?? '-'][0],
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(height: Adapt.px(60)),
          Container(
            height: Adapt.px(40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('****', style: _textStyle),
                Text('****', style: _textStyle),
                Text('****', style: _textStyle),
                Text(
                  '${creditCard?.lastFour ?? '****'}',
                  style: _textStyle,
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
            creditCard?.expirationDate ?? 'MM/yyyy',
            style: TextStyle(color: Color(0xFFFFFFFF)),
          )
        ],
      ),
    );
  }
}

class _PayPalCell extends StatelessWidget {
  final PayPalDetails details;
  const _PayPalCell({this.details});
  @override
  Widget build(BuildContext context) {
    final _cardColor = const Color(0xFF1080F0);
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
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              constraints: BoxConstraints(maxWidth: Adapt.px(150)),
              height: Adapt.px(50),
              child: Image.asset(
                'images/paypal_logo.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(height: Adapt.px(60)),
          Container(
            height: Adapt.px(40),
            child: Text(
              details?.payerEmail ?? '-',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: Adapt.px(28),
              ),
            ),
          ),
          Expanded(child: SizedBox()),
          Container(
            height: Adapt.px(40),
            child: Text(
              '${details?.payerFirstName ?? '-'} ${details?.payerLastName ?? '-'}',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: Adapt.px(28),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentMethodShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _cardColor = const Color(0xFF556677);
    final _contextColor = const Color(0xFF506070);
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
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: Adapt.px(80),
            height: Adapt.px(80),
            decoration: BoxDecoration(
              color: _contextColor,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(height: Adapt.px(50)),
        ],
      ),
    );
  }
}
