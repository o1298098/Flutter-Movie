import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/views/account_page_old/action.dart';

import 'state.dart';

Widget buildView(BodyState state, Dispatch dispatch, ViewService viewService) {
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
          onTap: () =>
              dispatch(AccountPageActionCreator.navigatorPush('watchlistPage')),
        ),
        _GirdCell(
          icon: 'images/luke_skywalker.png',
          title: 'MyLists',
          onTap: () =>
              dispatch(AccountPageActionCreator.navigatorPush('myListsPage')),
        ),
        _GirdCell(
          icon: 'images/darth_vader.png',
          title: 'Favorites',
          onTap: () =>
              dispatch(AccountPageActionCreator.navigatorPush('favoritesPage')),
        ),
        _GirdCell(
            icon: 'images/chewbacca.png',
            title: 'Payment',
            onTap: () => dispatch(
                AccountPageActionCreator.navigatorPush('paymentPage'))),
        _GirdCell(
            icon: 'images/c3po.png',
            title: 'Downloaded',
            onTap: () => dispatch(
                AccountPageActionCreator.navigatorPush('downloadPage'))),
        _GirdCell(
          icon: 'images/r2d2.png',
          title: 'Settings',
          onTap: () => dispatch(AccountPageActionCreator.settingCellTapped()),
        ),
      ],
    ),
  );
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
