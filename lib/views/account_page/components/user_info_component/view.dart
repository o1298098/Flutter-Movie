import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/views/account_page/components/user_info_component/component/user_menu.dart';
import 'package:movie/widgets/overlay_entry_manage.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    UserInfoState state, Dispatch dispatch, ViewService viewService) {
  void _closeMenu(OverlayEntry overlayEntry) {
    overlayEntry?.remove();
    state.overlayStateKey.currentState.setOverlayEntry(null);
    overlayEntry = null;
  }

  void _showMenu() {
    OverlayEntry menuOverlayEntry;
    menuOverlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: <Widget>[
            Positioned.fill(
                child: GestureDetector(
              onTap: () => _closeMenu(menuOverlayEntry),
              child: Container(
                color: Colors.transparent,
              ),
            )),
            UserMenu(
              onNotificationTap: () {
                _closeMenu(menuOverlayEntry);
                dispatch(UserInfoActionCreator.openNotifications());
              },
              onPaymentTap: () {
                _closeMenu(menuOverlayEntry);
                dispatch(UserInfoActionCreator.paymentTap());
              },
              onSignOut: () {
                _closeMenu(menuOverlayEntry);
                dispatch(UserInfoActionCreator.signOut());
              },
            )
          ],
        );
      },
    );
    state.overlayStateKey.currentState.setOverlayEntry(menuOverlayEntry);
    Overlay.of(viewService.context).insert(menuOverlayEntry);
  }

  return _Body(
    isSignIn: state.user?.firebaseUser != null,
    user: state.user?.firebaseUser,
    openMenu: _showMenu,
    onSignIn: () => dispatch(UserInfoActionCreator.signIn()),
    overlayStateKey: state.overlayStateKey,
  );
}

class _Body extends StatelessWidget {
  final bool isSignIn;
  final FirebaseUser user;
  final Key overlayStateKey;
  final Function openMenu;
  final Function onSignIn;
  const _Body(
      {this.isSignIn = false,
      this.openMenu,
      this.onSignIn,
      this.user,
      this.overlayStateKey});
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, Adapt.px(30), 0, 25),
          child: isSignIn
              ? _UserInfo(
                  profileUrl: user?.photoUrl,
                  userName: user?.displayName,
                  openMenu: openMenu,
                  overlayStateKey: overlayStateKey)
              : _SignInPanel(
                  onSignIn: onSignIn,
                ),
        ),
      ),
    );
  }
}

class _UserInfo extends StatelessWidget {
  final String userName;
  final String profileUrl;
  final Function openMenu;
  final Key overlayStateKey;
  const _UserInfo(
      {this.profileUrl, this.userName, this.openMenu, this.overlayStateKey});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    final _avatarSize = Adapt.px(80);
    final _avatarMargin = Adapt.px(5);
    final _avatarRadius = Adapt.px(20);
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              I18n.of(context).welcomeBack,
              style: TextStyle(color: const Color(0xFF717171), fontSize: 12),
            ),
            SizedBox(height: 5),
            Text(
              userName ?? 'UserName',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Spacer(),
        SizedBox(width: 15),
        Stack(
          children: [
            OverlayEntryManage(
              key: overlayStateKey,
              child: GestureDetector(
                onTap: openMenu,
                child: Container(
                  width: _avatarSize,
                  height: _avatarSize,
                  margin: EdgeInsets.all(_avatarMargin),
                  decoration: BoxDecoration(
                    color: _theme.primaryColorDark,
                    borderRadius: BorderRadius.circular(_avatarRadius),
                    image: profileUrl == null
                        ? null
                        : DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(profileUrl),
                          ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: _avatarSize - _avatarMargin),
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF5568E8),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SignInPanel extends StatelessWidget {
  final Function onSignIn;
  const _SignInPanel({this.onSignIn});
  @override
  Widget build(BuildContext context) {
    final _iconColor = const Color(0xFF717171);
    return Container(
      height: Adapt.px(90),
      child: Row(children: [
        Icon(
          FontAwesomeIcons.bell,
          size: 18,
          color: _iconColor,
        ),
        Spacer(),
        GestureDetector(
            onTap: onSignIn,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: _iconColor),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(children: [
                Text('Sign In'),
                SizedBox(width: Adapt.px(15)),
                Icon(
                  FontAwesomeIcons.user,
                  color: _iconColor,
                  size: 18,
                ),
              ]),
            ))
      ]),
    );
  }
}
