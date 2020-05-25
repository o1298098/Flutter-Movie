import 'dart:io';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/models/base_api_model/braintree_creditcard.dart';
import 'package:movie/style/themestyle.dart';

import 'state.dart';

Widget buildView(
    PaymentPageState state, Dispatch dispatch, ViewService viewService) {
  return Builder(builder: (context) {
    final _theme = ThemeStyle.getTheme(context);
    final List<CreditCard> _ccccc = []
      ..addAll(state.customer?.creditCards ?? [])
      ..addAll(state.customer?.creditCards ?? [])
      ..addAll(state.customer?.creditCards ?? []);
    return Scaffold(
      backgroundColor: _theme.primaryColorDark,
      appBar: AppBar(
        backgroundColor: _theme.primaryColorDark,
        brightness: _theme.brightness,
        iconTheme: _theme.iconTheme,
        elevation: 0.0,
        centerTitle: false,
        title: Text(
          'Payment',
          style: TextStyle(color: _theme.textTheme.bodyText1.color),
        ),
      ),
      body: Column(children: [
        _Header(),
        _Body(
          creditCards: _ccccc,
        ),
      ]),
    );
  });
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: Adapt.px(30)),
      Text.rich(
        TextSpan(children: [
          TextSpan(
            text: '\$2.99',
            style:
                TextStyle(fontSize: Adapt.px(60), fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: ' / month',
            style: TextStyle(fontSize: Adapt.px(28)),
          )
        ]),
      ),
      SizedBox(height: Adapt.px(10)),
      Text.rich(
        TextSpan(children: [
          TextSpan(
            text: 'Next Payment ',
            style: TextStyle(
              fontSize: Adapt.px(22),
              color: const Color(0xFF9E9E9E),
            ),
          ),
          TextSpan(
            text: '20th July, 2020',
            style: TextStyle(
              fontSize: Adapt.px(22),
            ),
          )
        ]),
      ),
      SizedBox(height: Adapt.px(50))
    ]);
  }
}

class _CreditCardCell extends StatelessWidget {
  final CreditCard creditCard;
  const _CreditCardCell({this.creditCard});

  @override
  Widget build(BuildContext context) {
    final _creditCardTheme = {
      'Visa': ['images/visa_logo.png', const Color(0xFF9E92E1)],
      'JCB': ['images/jcb_logo.png', const Color(0xFFE3C4C2)],
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Adapt.px(40)),
        color: const Color(0xFFFFFFFF),
      ),
      child: Container(
        width: Adapt.screenW(),
        height: Adapt.px(420),
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Adapt.px(40)),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              _cardColor.withAlpha(120),
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
            SizedBox(height: Adapt.px(80)),
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
      ),
    );
  }
}

class _OtherPaymentCell extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTap;
  const _OtherPaymentCell(
      {@required this.icon, @required this.title, this.onTap});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          Container(
            width: Adapt.px(80),
            height: Adapt.px(80),
            decoration: BoxDecoration(
              border: Border.all(
                  width: Adapt.px(2), color: const Color(0xFF9E9E9E)),
              borderRadius: BorderRadius.circular(Adapt.px(20)),
            ),
            child: Icon(icon, color: const Color(0xFF9E9E9E)),
          ),
          SizedBox(width: Adapt.px(20)),
          Text(
            title,
            style: TextStyle(fontSize: Adapt.px(28)),
          )
        ],
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final List<CreditCard> creditCards;
  const _Body({this.creditCards});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: _theme.backgroundColor,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(Adapt.px(60)),
          ),
        ),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(height: Adapt.px(80)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Adapt.px(60)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Saved Cards',
                    style: TextStyle(fontSize: Adapt.px(30)),
                  ),
                  Container(
                    width: Adapt.px(60),
                    height: Adapt.px(60),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFF9E9E9E),
                        width: .5,
                      ),
                      borderRadius: BorderRadius.circular(
                        Adapt.px(15),
                      ),
                    ),
                    child: Icon(
                      Icons.add,
                      size: Adapt.px(25),
                      color: const Color(0xFF9E9E9E),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: Adapt.px(50)),
            _CreditCardSwiper(
              creditCards: creditCards,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Adapt.px(60), vertical: Adapt.px(50)),
              child: Text(
                'Other Payments',
                style: TextStyle(fontSize: Adapt.px(30)),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Adapt.px(60)),
              child: Row(
                children: [
                  _OtherPaymentCell(
                    icon: FontAwesomeIcons.paypal,
                    title: 'Paypal',
                  ),
                  Expanded(child: SizedBox()),
                  Platform.isIOS
                      ? _OtherPaymentCell(
                          icon: FontAwesomeIcons.apple,
                          title: 'Apple Pay',
                        )
                      : _OtherPaymentCell(
                          icon: FontAwesomeIcons.google,
                          title: 'Google Pay',
                        )
                ],
              ),
            ),
            SizedBox(height: Adapt.px(80)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Adapt.px(60)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Payment History',
                    style: TextStyle(fontSize: Adapt.px(30)),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: Adapt.px(40),
                    color: const Color(0xFF9E9E9E),
                  )
                ],
              ),
            ),
            SizedBox(height: Adapt.px(80)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Adapt.px(60)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Bill Address',
                    style: TextStyle(fontSize: Adapt.px(30)),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: Adapt.px(40),
                    color: const Color(0xFF9E9E9E),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _CreditCardSwiper extends StatelessWidget {
  final List<CreditCard> creditCards;
  const _CreditCardSwiper({this.creditCards});
  @override
  Widget build(BuildContext context) {
    final int lenght = creditCards?.length ?? 0;
    List<double> _opacitys = [];
    List<double> _rotates = [];
    List<double> _scales = [];
    List<Offset> _offsets = [];
    if (lenght == 1) {
      _opacitys = [1.0];
      _rotates = [0.0];
      _scales = [.9];
      _offsets = [Offset.zero];
    } else if (lenght == 2) {
      _opacitys = [1.0, 0.0];
      _rotates = [0.0, 25 / 180];
      _scales = [.9, 1.0];
      _offsets = [
        Offset.zero,
        Offset(Adapt.screenW(), 0),
      ];
    } else if (lenght == 3) {
      _opacitys = [1.0, 1.0, 0.0];
      _rotates = [0.0, 0, 25 / 180];
      _scales = [0.85, 0.9, 1.0];
      _offsets = [
        Offset(0.0, -20),
        Offset.zero,
        Offset(Adapt.screenW(), 0),
      ];
    } else if (lenght == 4) {
      _opacitys = [1.0, 1.0, 0.0, 0.0];
      _rotates = [0, 0, 25 / 180, 0];
      _scales = [0.85, 0.9, 1.0, 1.0];
      _offsets = [
        Offset(0.0, -20),
        Offset.zero,
        Offset(Adapt.screenW(), 0),
        Offset(Adapt.screenW(), 0),
      ];
    } else if (lenght > 4) {
      _opacitys = [1.0, 1.0, 1.0, 0.0, 0.0];
      _rotates = [0, 0, 0, 25 / 180, 0];
      _scales = [0.8, 0.85, 0.9, 1.0, 1.0, 1.0];
      _offsets = [
        Offset(0.0, -40),
        Offset(0.0, -20),
        Offset.zero,
        Offset(Adapt.screenW(), 0),
        Offset(Adapt.screenW(), 0),
      ];
      List(lenght - 4).forEach((e) {
        _opacitys.insert(0, 0);
        _rotates.insert(0, 0);
        _scales.insert(0, 0);
        _offsets.insert(0, Offset.zero);
      });
    }

    final _controller = SwiperController();
    return Container(
      height: Adapt.px(480),
      child: Swiper(
        //scrollDirection: Axis.vertical,
        controller: _controller,
        itemCount: lenght,
        //viewportFraction: 0.9,
        layout: SwiperLayout.CUSTOM,
        customLayoutOption:
            CustomLayoutOption(stateCount: lenght, startIndex: 0)
                .addOpacity(_opacitys)
                .addRotate(_rotates)
                .addScale(_scales, Alignment.center)
                .addTranslate(_offsets),
        itemHeight: Adapt.px(420),
        itemWidth: Adapt.screenW(),
        itemBuilder: (context, index) {
          return _CreditCardCell(
            creditCard: creditCards[index],
          );
        },
      ),
    );
  }
}
