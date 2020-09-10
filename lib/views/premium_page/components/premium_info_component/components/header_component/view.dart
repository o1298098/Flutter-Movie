import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/models/app_user.dart';
import 'package:movie/models/base_api_model/user_premium_model.dart';
import 'package:movie/style/themestyle.dart';

import 'state.dart';

Widget buildView(
    HeaderState state, Dispatch dispatch, ViewService viewService) {
  return Container(
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
  );
}

class _HeaderInfo extends StatelessWidget {
  final AppUser user;
  const _HeaderInfo({@required this.user});
  @override
  Widget build(BuildContext context) {
    final _premiumInfo = {
      1: '\$ 2.99 / month',
      2: '\$ 6.99 / 3 months',
      3: '\$ 9.99 / 6 months',
      4: '\$ 16.99 / 1 year'
    };
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
              _premiumInfo[user?.premium?.premiumType ?? 1],
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
                      text: user.premium.subscription
                          ? DateFormat.yMMMd().format(
                              DateTime.parse(user.premium.expireDate)
                                  .add(Duration(days: 1)))
                          : '-',
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
