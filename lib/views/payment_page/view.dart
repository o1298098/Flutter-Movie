import 'dart:io';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/models/app_user.dart';
import 'package:movie/models/models.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/views/payment_page/action.dart';

import 'state.dart';

Widget buildView(
    PaymentPageState state, Dispatch dispatch, ViewService viewService) {
  return Builder(builder: (context) {
    final _theme = ThemeStyle.getTheme(context);
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
        _Header(user: state.user),
        _Body(
          creditCards: state.cards ?? null,
          dispatch: dispatch,
        ),
      ]),
    );
  });
}

class _Header extends StatelessWidget {
  final AppUser user;
  const _Header({this.user});
  @override
  Widget build(BuildContext context) {
    final _premiumType = user.premium?.premiumType ?? 0;
    final _premiumInfo = {
      0: ['-', ''],
      1: ['2.99', ''],
      2: ['6.99', '3'],
      3: ['9.99', '6'],
      4: ['16.99', '12']
    };
    return Column(children: [
      SizedBox(height: Adapt.px(30)),
      Text.rich(
        TextSpan(children: [
          TextSpan(
            text: '\$${_premiumInfo[_premiumType][0]}',
            style:
                TextStyle(fontSize: Adapt.px(60), fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text:
                ' / ${_premiumInfo[_premiumType][1]} month${_premiumType > 1 ? 's' : ''}',
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
            text: _premiumType > 0 && user.premium?.expireDate != null
                ? DateFormat.yMMMd().format(
                    DateTime.parse(user.premium.expireDate)
                        .add(Duration(days: 1)),
                  )
                : '-',
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

class _OptionCell extends StatelessWidget {
  final String title;
  final Function onTap;
  const _OptionCell({@required this.title, this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Adapt.px(60), vertical: Adapt.px(40)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
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
    );
  }
}

class _Body extends StatelessWidget {
  final List<StripeCreditCard> creditCards;
  final SwiperController controller;
  final Dispatch dispatch;
  const _Body({this.creditCards, this.controller, this.dispatch});
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
                  _AddCardButton(
                    onTap: () =>
                        dispatch(PaymentPageActionCreator.createCard()),
                  )
                ],
              ),
            ),
            SizedBox(height: Adapt.px(50)),
            creditCards == null
                ? _CreditCardSwiperShimmer(
                    controller: controller,
                  )
                : creditCards.length > 0
                    ? _CreditCardSwiper(
                        creditCards: creditCards,
                        controller: controller,
                      )
                    : _EmptyCreditCard(),
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
                    title: 'PayPal',
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
            SizedBox(height: Adapt.px(40)),
            _OptionCell(
              title: 'Payment History',
              onTap: () => dispatch(
                PaymentPageActionCreator.showHistory(),
              ),
            ),
            _OptionCell(
              title: 'Billing Address',
              onTap: () =>
                  dispatch(PaymentPageActionCreator.showBillingAddress()),
            )
          ],
        ),
      ),
    );
  }
}

class _AddCardButton extends StatelessWidget {
  final Function onTap;
  const _AddCardButton({this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
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
        ));
  }
}

class _CreditCardCell extends StatelessWidget {
  final StripeCreditCard creditCard;
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
    final Color _cardColor = _creditCardTheme[creditCard?.brand ?? '-'][1];

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
                  _creditCardTheme[creditCard?.brand ?? '-'][0],
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
                    '${creditCard?.last4 ?? '****'}',
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
              '${creditCard?.expMonth ?? 'MM'}/${creditCard?.expYear ?? 'yyyy'}',
              style: TextStyle(color: Color(0xFFFFFFFF)),
            )
          ],
        ),
      ),
    );
  }
}

class _CreditCardSwiper extends StatelessWidget {
  final List<StripeCreditCard> creditCards;
  final SwiperController controller;
  const _CreditCardSwiper({this.creditCards, this.controller});
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
      _rotates = [0.0, 0.0, 0.0, 25 / 180, 0.0];
      _scales = [0.8, 0.85, 0.9, 1.0, 1.0, 1.0];
      _offsets = [
        Offset(0.0, -40),
        Offset(0.0, -20),
        Offset.zero,
        Offset(Adapt.screenW(), 0),
        Offset(Adapt.screenW(), 0),
      ];
      List.filled(lenght - 4, 0).forEach((e) {
        _opacitys.insert(0, 0);
        _rotates.insert(0, 0);
        _scales.insert(0, 0);
        _offsets.insert(0, Offset.zero);
      });
    }
    return Container(
      height: Adapt.px(480),
      child: Swiper(
        controller: controller,
        itemCount: lenght,
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

class _CreditCardSwiperShimmer extends StatelessWidget {
  final SwiperController controller;
  const _CreditCardSwiperShimmer({this.controller});
  @override
  Widget build(BuildContext context) {
    final _opacitys = [1.0, 1.0, 1.0, 0.0, 0.0];
    final _rotates = [0.0, 0.0, 0.0, 25 / 180, 0.0];
    final _scales = [0.8, 0.85, 0.9, 1.0, 1.0, 1.0];
    final _offsets = [
      Offset(0.0, -40),
      Offset(0.0, -20),
      Offset.zero,
      Offset(Adapt.screenW(), 0),
      Offset(Adapt.screenW(), 0),
    ];
    final _cardColors = [
      const Color(0xFF9E92E1),
      const Color(0xFF556677),
      const Color(0xFFE3C4C2),
      const Color(0XFF66AA9E),
      const Color(0xFF556677),
    ];
    return Container(
        height: Adapt.px(480),
        child: Swiper(
          controller: controller,
          itemCount: 5,
          layout: SwiperLayout.CUSTOM,
          customLayoutOption: CustomLayoutOption(stateCount: 5, startIndex: 2)
              .addOpacity(_opacitys)
              .addRotate(_rotates)
              .addScale(_scales, Alignment.center)
              .addTranslate(_offsets),
          itemHeight: Adapt.px(420),
          itemWidth: Adapt.screenW(),
          itemBuilder: (context, index) {
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
                      _cardColors[index].withAlpha(120),
                      _cardColors[index].withAlpha(200),
                      _cardColors[index],
                    ],
                  ),
                ),
                child: Center(
                  child: Text(
                    'Loading',
                    style: TextStyle(
                      fontSize: Adapt.px(40),
                      color: const Color(0xFFFFFFFF),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}

class _EmptyCreditCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: Adapt.px(480), child: Center(child: Text('empty')));
  }
}
