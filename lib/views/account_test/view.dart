import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/style/themestyle.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    AccountState state, Dispatch dispatch, ViewService viewService) {
  return Builder(builder: (context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDF6FD),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            _UserInfo(
              profileUrl: state.user?.firebaseUser?.photoUrl,
              userName: state.user?.firebaseUser?.displayName,
            ),
            _SecondPanel(),
            _TipPanel(),
            SliverToBoxAdapter(
              child: _TabBarPanel(
                currentIndex: state.selectedTabBarIndex,
                onTap: (index) =>
                    dispatch(AccountActionCreator.onTabBarTap(index)),
              ),
            ),
            _FeaturesPanel(
              index: state.selectedTabBarIndex,
            )
          ],
        ),
      ),
    );
  });
}

class _UserInfo extends StatelessWidget {
  final String userName;
  final String profileUrl;
  const _UserInfo({this.profileUrl, this.userName});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    return SliverToBoxAdapter(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 25),
          child: Row(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back',
                  style:
                      TextStyle(color: const Color(0xFF717171), fontSize: 12),
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
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: _theme.primaryColorDark,
                borderRadius: BorderRadius.circular(10),
                image: profileUrl == null
                    ? null
                    : DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(profileUrl),
                      ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class _SecondPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(bottom: 25),
        height: Adapt.px(220),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: const Color(0xFF5568E8),
        ),
      ),
    );
  }
}

class _TipPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        padding: EdgeInsets.symmetric(horizontal: 15),
        height: Adapt.px(90),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0xFFD1ECFD),
        ),
        child: Row(
          children: [
            Text(
              'This panel for User Tip',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: const Color(0xFF243586),
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: const Color(0xFFE2F4FE),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.close,
                color: const Color(0xFF5A6FE8),
                size: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _TabBarPanel extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;
  const _TabBarPanel({this.currentIndex, this.onTap});
  @override
  _TabPanelState createState() => _TabPanelState();
}

class _TabPanelState extends State<_TabBarPanel> with TickerProviderStateMixin {
  AnimationController _controller;
  final Tween<Offset> _tween =
      Tween<Offset>(begin: Offset.zero, end: Offset(2, 0));
  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap(int index) {
    if (index == widget.currentIndex) return;
    if (widget.onTap != null) widget.onTap(index);
    _controller.animateTo(index / 2,
        curve: Curves.ease, duration: Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    return Stack(
      children: [
        SlideTransition(
          position: _tween.animate(_controller),
          child: Container(
            width: 100,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: _theme.backgroundColor,
              boxShadow: [
                BoxShadow(
                  blurRadius: 8,
                  spreadRadius: -3,
                  color: Color(0xFFD0D0D0),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 25),
          child: Row(
            children: [
              _TabCell(
                title: 'Account',
                selected: widget.currentIndex == 0,
                index: 0,
                onTap: _onTap,
              ),
              _TabCell(
                title: 'Payment',
                selected: widget.currentIndex == 1,
                index: 1,
                onTap: _onTap,
              ),
              _TabCell(
                title: 'Settings',
                selected: widget.currentIndex == 2,
                index: 2,
                onTap: _onTap,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TabCell extends StatelessWidget {
  final String title;
  final int index;
  final Function(int) onTap;
  final bool selected;
  const _TabCell({
    this.title,
    this.selected = false,
    this.index,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    final _selectedStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: const Color(0xFF252771),
    );
    final _unSelectedStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: const Color(0xFFBEBEBE),
    );
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        width: 100,
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Center(
          child: Text(
            title,
            style: selected ? _selectedStyle : _unSelectedStyle,
          ),
        ),
      ),
    );
  }
}

class _FeaturesPanel extends StatelessWidget {
  final int index;
  const _FeaturesPanel({this.index});
  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return _UserDataPanel();
      case 1:
        return _PaymenyPanel();
      default:
        return SliverToBoxAdapter(
          child: Text('settings'),
        );
    }
  }
}

class _UserDataPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      childAspectRatio: 1.2,
      children: [
        _FeaturesCell(
          title: 'Favorites',
          value: '12',
        ),
        _FeaturesCell(
          title: 'My Lists',
          value: '9',
        ),
        _FeaturesCell(
          title: 'Watch Lists',
          value: '5',
        ),
        _FeaturesCell(
          title: 'Cast Lists',
          value: '9',
        ),
      ],
    );
  }
}

class _FeaturesCell extends StatelessWidget {
  final String title;
  final String value;
  final Function onTap;
  const _FeaturesCell({this.title, this.value, this.onTap});
  @override
  Widget build(BuildContext context) {
    // final _size = MediaQuery.of(context).size;
    // final _height = (_size.width - 70) / 2.4;
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFFF),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFE2F4FE),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          SizedBox(height: 15),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: const Color(0xFF717171),
            ),
          )
        ],
      ),
    );
  }
}

class _PaymenyPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverGrid.count(
      crossAxisCount: 2,
      childAspectRatio: 1.2,
      children: [],
    );
  }
}
