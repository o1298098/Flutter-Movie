import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/customwidgets/customcliper_path.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    AccountPageState state, Dispatch dispatch, ViewService viewService) {
  return Builder(builder: (context) {
    return Scaffold(
      key: state.scafoldState,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Stack(
          children: <Widget>[
            _BackGround(),
            Container(
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: Adapt.px(60)),
                    _Header(
                      user: state.user,
                      dispatch: dispatch,
                    ),
                    SizedBox(height: Adapt.px(50)),
                    _AccountBody(dispatch: dispatch),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  });
}

class _DropDownItem extends StatelessWidget {
  final String title;
  final IconData icon;
  const _DropDownItem({@required this.title, this.icon});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[Icon(icon), SizedBox(width: 10), Text(title)],
    );
  }
}

class _BackGround extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
        clipper: CustomCliperPath(
            height: Adapt.px(380),
            width: Adapt.screenW(),
            radius: Adapt.px(2000)),
        child: Container(
          height: Adapt.px(380),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  const Color(0xFF6495ED),
                  const Color(0xFF6A5ACD),
                ],
                stops: <double>[
                  0.0,
                  1.0
                ]),
          ),
        ));
  }
}

class _Header extends StatelessWidget {
  final FirebaseUser user;
  final Dispatch dispatch;
  const _Header({this.user, this.dispatch});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(width: Adapt.px(40)),
        SizedBox(
          width: Adapt.screenW() - Adapt.px(225),
          child: Text(
            'Hi, ${user?.displayName ?? 'Guest'}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: Adapt.px(60),
            ),
          ),
        ),
        Expanded(child: SizedBox()),
        user == null
            ? InkWell(
                onTap: () => dispatch(AccountPageActionCreator.onLogin()),
                child: Container(
                    height: Adapt.px(60),
                    margin: EdgeInsets.only(
                        right: Adapt.px(30),
                        top: Adapt.px(13),
                        bottom: Adapt.px(13)),
                    padding: EdgeInsets.symmetric(
                        horizontal: Adapt.px(20), vertical: Adapt.px(10)),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Adapt.px(30)),
                        border: Border.all(
                            color: const Color(0xFFFFFFFF), width: 2)),
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                          color: const Color(0xFFFFFFFF),
                          fontSize: Adapt.px(26)),
                    )))
            : PopupMenuButton<String>(
                padding: EdgeInsets.zero,
                offset: Offset(0, Adapt.px(100)),
                icon: Icon(
                  Icons.more_vert,
                  color: const Color(0xFFFFFFFF),
                  size: Adapt.px(50),
                ),
                onSelected: (selected) {
                  switch (selected) {
                    case 'Sign Out':
                      dispatch(AccountPageActionCreator.onLogout());
                      break;
                  }
                },
                itemBuilder: (ctx) {
                  return [
                    PopupMenuItem<String>(
                      value: 'Notifications',
                      child: const _DropDownItem(
                        title: 'Notifications',
                        icon: Icons.notifications_none,
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'Sign Out',
                      child: const _DropDownItem(
                        title: 'Sign Out',
                        icon: Icons.exit_to_app,
                      ),
                    ),
                  ];
                },
              ),
        SizedBox(width: Adapt.px(10))
      ],
    );
  }
}

class _GirdCell extends StatelessWidget {
  final Function onTap;
  final String icon;
  final String title;

  const _GirdCell({this.icon, this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    final _lightTheme = ThemeData.light()
        .copyWith(cardColor: Colors.white, canvasColor: Colors.grey[300]);
    final _darkTheme = ThemeData.dark()
        .copyWith(cardColor: Color(0xFF505050), canvasColor: Color(0xFF404040));
    final MediaQueryData _mediaQuery = MediaQuery.of(context);
    final ThemeData _theme = _mediaQuery.platformBrightness == Brightness.light
        ? _lightTheme
        : _darkTheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.fromLTRB(
            Adapt.px(10), Adapt.px(10), Adapt.px(10), Adapt.px(30)),
        decoration: BoxDecoration(
          color: _theme.cardColor,
          borderRadius: BorderRadius.circular(Adapt.px(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                blurRadius: Adapt.px(10),
                color: _theme.canvasColor,
                offset: Offset(0, Adapt.px(15)))
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              icon,
              width: Adapt.px(100),
              height: Adapt.px(100),
            ),
            SizedBox(height: Adapt.px(20)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Adapt.px(10)),
              child: Text(
                title,
                style: TextStyle(
                    fontSize: Adapt.px(30), fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _AccountBody extends StatelessWidget {
  final Dispatch dispatch;
  const _AccountBody({this.dispatch});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisSpacing: Adapt.px(30),
        shrinkWrap: true,
        crossAxisCount: 2,
        children: <Widget>[
          _GirdCell(
            icon: 'images/yoda.png',
            title: 'Watchlist',
            onTap: () => dispatch(
                AccountPageActionCreator.navigatorPush('WatchlistPage')),
          ),
          _GirdCell(
            icon: 'images/luke_skywalker.png',
            title: 'MyLists',
            onTap: () =>
                dispatch(AccountPageActionCreator.navigatorPush('MyListsPage')),
          ),
          _GirdCell(
            icon: 'images/darth_vader.png',
            title: 'Favorites',
            onTap: () => dispatch(
                AccountPageActionCreator.navigatorPush('FavoritesPage')),
          ),
          _GirdCell(
              icon: 'images/chewbacca.png',
              title: 'Stream Links',
              onTap: () {}),
          _GirdCell(
              icon: 'images/c3po.png',
              title: 'MyRated',
              onTap: () =>
                  dispatch(AccountPageActionCreator.navigatorPush('testPage'))),
          _GirdCell(
            icon: 'images/r2d2.png',
            title: 'Settings',
            onTap: () => dispatch(AccountPageActionCreator.settingCellTapped()),
          ),
        ],
      ),
    );
  }
}
