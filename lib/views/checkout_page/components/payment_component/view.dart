import 'dart:io';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie/style/themestyle.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    PaymentState state, Dispatch dispatch, ViewService viewService) {
  final _theme = ThemeStyle.getTheme(viewService.context);
  final _mediaQuery = MediaQuery.of(viewService.context);
  final _isAndroid = Platform.isAndroid;
  return Scaffold(
    backgroundColor: Colors.transparent,
    body: Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 35),
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: _theme.backgroundColor,
        ),
        width: _mediaQuery.size.width,
        height: 360,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment methods',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Choose a payment method to pay',
              style: TextStyle(
                  color: const Color(0xFF717171),
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 40),
            _PaymentCell(
              icon: FontAwesomeIcons.creditCard,
              title: 'Credit Card',
              selected: !state.nativePay,
              onTap: () => dispatch(PaymentActionCreator.selectPayment(false)),
            ),
            SizedBox(height: 20),
            _PaymentCell(
              icon:
                  _isAndroid ? FontAwesomeIcons.google : FontAwesomeIcons.apple,
              title: _isAndroid ? 'Google Pay' : 'Apple Pay',
              selected: state.nativePay,
              onTap: () => dispatch(PaymentActionCreator.selectPayment(true)),
            ),
          ],
        ),
      ),
    ),
  );
}

class _PaymentCell extends StatelessWidget {
  final bool selected;
  final Function onTap;
  final IconData icon;
  final String title;
  const _PaymentCell({this.onTap, this.selected = false, this.icon, this.title})
      : assert(title != null && icon != null);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        decoration: BoxDecoration(
          color: selected ? Colors.orange.withAlpha(10) : null,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? Colors.orange.withAlpha(200) : Colors.grey[400],
          ),
        ),
        child: Row(
          children: [
            Icon(icon),
            SizedBox(width: 25),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Spacer(),
            Icon(Icons.keyboard_arrow_right_rounded),
          ],
        ),
      ),
    );
  }
}
