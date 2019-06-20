import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/customwidgets/keepalivewidget.dart';

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
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_creation),
            title: Text('Discvoer'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Account'),
          ), 
        ],
        currentIndex: state.selectedIndex,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,        
        onTap: (int index) {
          pageController.jumpToPage(index);
        },
        type: BottomNavigationBarType.fixed,
      ),
    );
}
