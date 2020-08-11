import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/style/themestyle.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    AccountState state, Dispatch dispatch, ViewService viewService) {
  return Builder(
    builder: (context) {
      final _theme = ThemeStyle.getTheme(context);
      return Scaffold(
        backgroundColor: const Color(0xFFEDF6FD),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: _theme.brightness == Brightness.light
              ? SystemUiOverlayStyle.dark
              : SystemUiOverlayStyle.light,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                _UserInfo(
                  profileUrl: state.user?.firebaseUser?.photoUrl,
                  userName: state.user?.firebaseUser?.displayName,
                ),
                _SecondPanel(),
                SliverToBoxAdapter(
                    child: _TipPanel(
                  show: state.showTip,
                  onChange: (show) =>
                      dispatch(AccountActionCreator.showTip(show)),
                )),
                SliverToBoxAdapter(
                  child: _TabBarPanel(
                    currentIndex: state.selectedTabBarIndex,
                    onTap: (index) =>
                        dispatch(AccountActionCreator.onTabBarTap(index)),
                  ),
                ),
                _FeaturesPanel(
                  index: state.selectedTabBarIndex,
                  dispatch: dispatch,
                )
              ],
            ),
          ),
        ),
      );
    },
  );
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
          child: Row(
            children: [
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
              Stack(
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    margin: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: _theme.primaryColorDark,
                      borderRadius: BorderRadius.circular(12),
                      image: profileUrl == null
                          ? null
                          : DecorationImage(
                              fit: BoxFit.cover,
                              image: CachedNetworkImageProvider(profileUrl),
                            ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 41),
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
          ),
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

class _TipPanel extends StatefulWidget {
  final bool show;
  final Function(bool) onChange;
  const _TipPanel({this.show = true, this.onChange});
  @override
  _TipPanelState createState() => _TipPanelState();
}

class _TipPanelState extends State<_TipPanel> with TickerProviderStateMixin {
  bool _show;
  AnimationController _controller;
  Animation<double> _heightAnimation;
  Animation<double> _opacityAnimation;
  @override
  void initState() {
    _show = widget.show;
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _heightAnimation = Tween<double>(begin: Adapt.px(90), end: 0.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.ease));
    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.ease));
    super.initState();
  }

  @override
  void didUpdateWidget(_TipPanel oldWidget) {
    if (_show != widget.show) {
      if (widget.show)
        _open();
      else
        _close();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  _setShow(bool show) {
    if (show == _show) return;
    setState(() {
      _show = show;
    });
  }

  _open() {
    _setShow(true);
    _controller.reverse();
  }

  _close() {
    _controller.forward();
    _setShow(false);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          return Opacity(
              opacity: _opacityAnimation.value,
              child: Container(
                margin: _show ? EdgeInsets.only(bottom: 20) : null,
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: _heightAnimation.value,
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
                    _show
                        ? GestureDetector(
                            onTap: () {
                              _close();
                              if (widget.onChange != null)
                                widget.onChange(_show);
                            },
                            child: Container(
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
                            ),
                          )
                        : SizedBox()
                  ],
                ),
              ));
        });
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
  final Dispatch dispatch;
  const _FeaturesPanel({
    this.index,
    this.dispatch,
  });
  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return _UserDataPanel(dispatch: dispatch);
      case 1:
        return _PaymenyPanel();
      case 2:
        return _SettingsPanel();
      default:
        return SliverToBoxAdapter();
    }
  }
}

class _UserDataPanel extends StatelessWidget {
  final Dispatch dispatch;
  const _UserDataPanel({this.dispatch});
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
          onTap: () =>
              dispatch(AccountActionCreator.navigatorPush('favoritesPage')),
        ),
        _FeaturesCell(
          title: 'My Lists',
          value: '9',
          onTap: () =>
              dispatch(AccountActionCreator.navigatorPush('myListsPage')),
        ),
        _FeaturesCell(
          title: 'Watch Lists',
          value: '5',
          onTap: () =>
              dispatch(AccountActionCreator.navigatorPush('watchlistPage')),
        ),
        _FeaturesCell(
          title: 'Cast Lists',
          value: '9',
          onTap: () =>
              dispatch(AccountActionCreator.navigatorPush('castListPage')),
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
      ),
    );
  }
}

class _PaymenyPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Text('payment'),
    );
  }
}

class _SettingsPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Text('settings'),
    );
  }
}
