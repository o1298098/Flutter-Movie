import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/models/base_api_model/account_info.dart';
import 'package:movie/style/themestyle.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    UserDataState state, Dispatch dispatch, ViewService viewService) {
  return _UserDataPanel(
    dispatch: dispatch,
    info: state.info,
  );
}

class _UserDataPanel extends StatelessWidget {
  final Dispatch dispatch;
  final AccountInfo info;
  const _UserDataPanel({this.dispatch, this.info});
  @override
  Widget build(BuildContext context) {
    return SliverGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: Adapt.px(35),
      crossAxisSpacing: Adapt.px(35),
      childAspectRatio: 1.2,
      children: [
        _FeaturesCell(
          title: 'Favorites',
          value: '${info?.favorites ?? 0}',
          icon: 'images/account_icon.png',
          onTap: () =>
              dispatch(UserDataActionCreator.navigatorPush('favoritesPage')),
        ),
        _FeaturesCell(
          title: 'My Lists',
          value: '${info?.myLists ?? 0}',
          icon: 'images/account_icon2.png',
          onTap: () =>
              dispatch(UserDataActionCreator.navigatorPush('myListsPage')),
        ),
        _FeaturesCell(
          title: 'Watch Lists',
          value: '${info?.watchLists ?? 0}',
          icon: 'images/account_icon3.png',
          onTap: () =>
              dispatch(UserDataActionCreator.navigatorPush('watchlistPage')),
        ),
        _FeaturesCell(
          title: 'Cast Lists',
          value: '${info?.castLists ?? 0}',
          icon: 'images/account_icon4.png',
          onTap: () =>
              dispatch(UserDataActionCreator.navigatorPush('castListPage')),
        ),
      ],
    );
  }
}

class _FeaturesCell extends StatelessWidget {
  final String title;
  final String value;
  final Function onTap;
  final String icon;
  const _FeaturesCell({this.title, this.value, this.onTap, this.icon});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(color: _theme.primaryColorDark),
          color: _theme.cardColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: Adapt.px(100),
              height: Adapt.px(80),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: icon != null
                    ? DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(icon),
                      )
                    : null,
              ),
            ),
            SizedBox(height: Adapt.px(20)),
            Text(
              title,
              style: TextStyle(
                fontSize: Adapt.px(26),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: Adapt.px(10)),
            Text(
              value,
              style: TextStyle(
                fontSize: Adapt.px(22),
                color: const Color(0xFF717171),
              ),
            )
          ],
        ),
      ),
    );
  }
}
