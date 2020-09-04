import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/widgets/keepalive_widget.dart';
import 'package:movie/generated/i18n.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    MainPageState state, Dispatch dispatch, ViewService viewService) {
  return Builder(
    builder: (context) {
      Adapt.initContext(context);
      final pageController = PageController();
      final _lightTheme = ThemeData.light().copyWith(
          backgroundColor: Colors.white,
          tabBarTheme: TabBarTheme(
              labelColor: Color(0XFF505050),
              unselectedLabelColor: Colors.grey));
      final _darkTheme = ThemeData.dark().copyWith(
          backgroundColor: Color(0xFF303030),
          tabBarTheme: TabBarTheme(
              labelColor: Colors.white, unselectedLabelColor: Colors.grey));
      final MediaQueryData _mediaQuery = MediaQuery.of(context);
      final ThemeData _theme =
          _mediaQuery.platformBrightness == Brightness.light
              ? _lightTheme
              : _darkTheme;
      Widget _buildPage(Widget page) {
        return KeepAliveWidget(page);
      }

      return Scaffold(
        key: state.scaffoldKey,
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          children: state.pages.map(_buildPage).toList(),
          controller: pageController,
          onPageChanged: (int i) =>
              dispatch(MainPageActionCreator.onTabChanged(i)),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: _theme.backgroundColor,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                  state.selectedIndex == 0 ? Icons.home : Icons.home_outlined,
                  size: Adapt.px(44)),
              label: I18n.of(context).home,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                  state.selectedIndex == 1
                      ? Icons.movie_creation
                      : Icons.movie_creation_outlined,
                  size: Adapt.px(44)),
              label: I18n.of(context).discover,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                  state.selectedIndex == 2
                      ? Icons.calendar_today
                      : Icons.calendar_today_outlined,
                  size: Adapt.px(44)),
              label: I18n.of(context).coming,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                state.selectedIndex == 3
                    ? Icons.account_circle
                    : Icons.account_circle_outlined,
                size: Adapt.px(44),
              ),
              label: I18n.of(context).account,
            ),
          ],
          currentIndex: state.selectedIndex,
          selectedItemColor: _theme.tabBarTheme.labelColor,
          unselectedItemColor: _theme.tabBarTheme.unselectedLabelColor,
          onTap: (int index) {
            pageController.jumpToPage(index);
          },
          type: BottomNavigationBarType.fixed,
        ),
      );
    },
  );
}
