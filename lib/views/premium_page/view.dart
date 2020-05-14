import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/models/base_api_model/checkout_model.dart';
import 'package:movie/models/enums/premium_type.dart';
import 'package:movie/style/themestyle.dart';
import 'state.dart';

Widget buildView(
    PremiumPageState state, Dispatch dispatch, ViewService viewService) {
  return Builder(
    builder: (context) {
      final _theme = ThemeStyle.getTheme(context);
      SystemChrome.setSystemUIOverlayStyle(_theme.brightness == Brightness.light
          ? SystemUiOverlayStyle.dark
          : SystemUiOverlayStyle.light);
      return Scaffold(
        body: SafeArea(
          child: Container(
            width: Adapt.screenW(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: Adapt.px(60)),
                _Title(),
                SizedBox(height: Adapt.px(60)),
                Text(
                  'Balalalalalalalala',
                  style: TextStyle(
                      fontSize: Adapt.px(40), fontWeight: FontWeight.bold),
                ),
                SizedBox(height: Adapt.px(60)),
                Expanded(
                  child: SizedBox(
                    width: Adapt.px(450),
                    child: Placeholder(),
                  ),
                ),
                SizedBox(height: Adapt.px(60)),
                _ItemCell(),
                SizedBox(height: Adapt.px(60)),
                _ItemCell(),
                SizedBox(height: Adapt.px(60)),
                _ItemCell(),
                SizedBox(height: Adapt.px(80)),
                _OneMonthButton(
                  onTap: () async => await Navigator.of(context)
                      .pushNamed('checkoutPage', arguments: {
                    'data': CheckOutModel(
                        name: 'Premium one month',
                        amount: 2.99,
                        isPremium: true)
                  }),
                ),
                SizedBox(height: Adapt.px(20)),
                _ThreeMonthButton(
                  onTap: () async => await Navigator.of(context)
                      .pushNamed('checkoutPage', arguments: {
                    'data': CheckOutModel(
                        name: 'Premium three months',
                        amount: 6.99,
                        isPremium: true,
                        premiumType: PremiumType.threeMonths)
                  }),
                ),
                SizedBox(height: Adapt.px(30)),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class _Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: Adapt.px(50),
        child: Stack(
          children: [
            Center(
              child: Text(
                'PREMIUM',
                style: TextStyle(fontSize: Adapt.px(30)),
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: Adapt.px(40)),
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: Icon(
                  Icons.close,
                  size: Adapt.px(50),
                ),
              ),
            ),
          ],
        ));
  }
}

class _ItemCell extends StatelessWidget {
  final String icon;
  final String title;
  final String description;
  const _ItemCell({this.icon, this.title, this.description});
  @override
  Widget build(BuildContext context) {
    final padding = Adapt.px(60);
    final width = Adapt.screenW() - 2 * padding;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Row(children: [
        Container(
          width: Adapt.px(60),
          height: Adapt.px(60),
          decoration: BoxDecoration(
            color: Color(0xFF505050),
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: Adapt.px(30)),
        SizedBox(
            width: width - Adapt.px(90),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'All the XXXXXXX',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: Adapt.px(30)),
              ),
              Text(
                'get all the video without ad, download what you like, watch this premium video for free',
                style: TextStyle(fontSize: Adapt.px(24)),
              )
            ]))
      ]),
    );
  }
}

class _OneMonthButton extends StatelessWidget {
  final Function onTap;
  const _OneMonthButton({this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: Adapt.px(80),
        width: Adapt.px(500),
        decoration: BoxDecoration(
          color: const Color(0xDD000000),
          borderRadius: BorderRadius.circular(Adapt.px(40)),
        ),
        child: Center(
          child: Text(
            '\$ 2.99 per/Month',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: const Color(0xFFFFFFFF),
            ),
          ),
        ),
      ),
    );
  }
}

class _ThreeMonthButton extends StatelessWidget {
  final Function onTap;
  const _ThreeMonthButton({this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: Adapt.px(80),
        width: Adapt.px(500),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFA0A0A0)),
          borderRadius: BorderRadius.circular(Adapt.px(40)),
        ),
        child: Center(
          child: Text(
            '\$ 6.99 3 Month',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: const Color(0xFFA0A0A0),
            ),
          ),
        ),
      ),
    );
  }
}
