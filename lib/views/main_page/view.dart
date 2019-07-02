import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/customwidgets/keepalivewidget.dart';
import 'package:movie/generated/i18n.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(MainPageState state, Dispatch dispatch, ViewService viewService) {
  final pageController = PageController();

  Widget _buildPage(Widget page)
  {
    return KeepAliveWidget(page);
  }

  return Scaffold(
      backgroundColor: Colors.white,
      body:PageView(
        children:state.pages.map(_buildPage).toList(),
        controller: pageController,
        onPageChanged: (int i) => dispatch(MainPageActionCreator.onTabChanged(i)),
        ),
        bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(I18n.of(viewService.context).home),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_creation),
            title: Text(I18n.of(viewService.context).discover),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            title: Text(I18n.of(viewService.context).coming),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text(I18n.of(viewService.context).account),
          ), 
        ],
        currentIndex: state.selectedIndex,
        selectedItemColor: Colors.black87,
        unselectedItemColor: Colors.grey,        
        onTap: (int index) {
          pageController.jumpToPage(index);
        },
        type: BottomNavigationBarType.fixed,
      ),
    );
}
