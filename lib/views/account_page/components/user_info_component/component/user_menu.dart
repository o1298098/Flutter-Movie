import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/style/themestyle.dart';

import 'arrow_clipper.dart';

class UserMenu extends StatelessWidget {
  final Function onSignOut;
  final Function onNotificationTap;
  final Function onPaymentTap;
  const UserMenu({this.onSignOut, this.onNotificationTap, this.onPaymentTap});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    final _backGroundColor = _theme.brightness == Brightness.light
        ? const Color(0xFF25272E)
        : _theme.primaryColorDark;
    final double _width = 200;
    final double _arrowSize = 15.0;
    return Positioned(
      top: Adapt.px(130) + Adapt.padTopH(),
      right: Adapt.px(40),
      width: _width,
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(right: Adapt.px(35)),
              alignment: Alignment.bottomRight,
              child: ClipPath(
                clipper: ArrowClipper(),
                child: Container(
                  width: _arrowSize,
                  height: _arrowSize,
                  color: _backGroundColor,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: _arrowSize / 2 - 1),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _backGroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(children: [
                _OptionItem(
                  icon: FontAwesomeIcons.bell,
                  title: 'Notifications',
                  onTap: onNotificationTap,
                ),
                _OptionItem(
                  icon: FontAwesomeIcons.user,
                  title: 'Profile',
                ),
                _OptionItem(
                  icon: Icons.payment_outlined,
                  title: 'Payment',
                  onTap: onPaymentTap,
                ),
                _OptionItem(
                  icon: Icons.exit_to_app,
                  title: 'Sign out',
                  onTap: onSignOut,
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class _OptionItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTap;
  const _OptionItem({@required this.title, @required this.icon, this.onTap});
  @override
  Widget build(BuildContext context) {
    final Color _baseColor = const Color(0xFFFFFFFF);
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 50,
        child: Row(
          children: [
            Icon(
              icon,
              color: _baseColor,
              size: 16,
            ),
            SizedBox(width: 20),
            Text(
              title,
              style: TextStyle(color: _baseColor, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
