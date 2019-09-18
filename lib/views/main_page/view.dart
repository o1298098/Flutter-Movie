import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/customwidgets/keepalive_widget.dart';
import 'package:movie/generated/i18n.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    MainPageState state, Dispatch dispatch, ViewService viewService) {
  final pageController = PageController();

  Widget _buildPage(Widget page) {
    return KeepAliveWidget(page);
  }

  return Scaffold(
    body: PageView(
      physics: ClampingScrollPhysics(),
      children: state.pages.map(_buildPage).toList(),
      controller: pageController,
      onPageChanged: (int i) => dispatch(MainPageActionCreator.onTabChanged(i)),
    ),
    bottomNavigationBar: BottomNavigationBar(
      backgroundColor: Theme.of(viewService.context).backgroundColor,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home, size: Adapt.px(44)),
          title: Text(I18n.of(viewService.context).home),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.movie_creation, size: Adapt.px(44)),
          title: Text(I18n.of(viewService.context).discover),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today, size: Adapt.px(44)),
          title: Text(I18n.of(viewService.context).coming),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.account_circle,
            size: Adapt.px(44),
          ),
          title: Text(I18n.of(viewService.context).account),
        ),
      ],
      currentIndex: state.selectedIndex,
      selectedItemColor: Theme.of(viewService.context).tabBarTheme.labelColor,
      unselectedItemColor:
          Theme.of(viewService.context).tabBarTheme.unselectedLabelColor,
      onTap: (int index) {
        pageController.jumpToPage(index);
      },
      type: BottomNavigationBarType.fixed,
    ),
  );
}
