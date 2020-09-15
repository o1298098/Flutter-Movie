import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/style/themestyle.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    AccountState state, Dispatch dispatch, ViewService viewService) {
  return Builder(
    builder: (context) {
      final _theme = ThemeStyle.getTheme(context);
      return Scaffold(
        // backgroundColor: const Color(0xFFEDF6FD),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: _theme.brightness == Brightness.light
              ? SystemUiOverlayStyle.dark
              : SystemUiOverlayStyle.light,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
            child: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                viewService.buildComponent('userInfo'),
                viewService.buildComponent('dataPanel'),
                SliverToBoxAdapter(
                    child: _TipPanel(
                  show: state.showTip,
                  tip: state.tip,
                  autoClose: true,
                  onChange: (show) => dispatch(AccountActionCreator.hideTip()),
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
                  viewService: viewService,
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}

class _TipPanel extends StatefulWidget {
  final bool show;
  final bool autoClose;
  final String tip;
  final Function(bool) onChange;
  const _TipPanel(
      {this.show = true, this.onChange, this.tip, this.autoClose = false});
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
    _heightAnimation = Tween<double>(begin: Adapt.px(90), end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
        reverseCurve: Curves.ease,
      ),
    );
    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.4, curve: Curves.ease),
        reverseCurve: Interval(0.0, 0.4, curve: Curves.ease),
      ),
    );
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
    if (widget.autoClose)
      Future.delayed(Duration(seconds: 5), () {
        _close();
        if (widget.onChange != null) widget.onChange(_show);
      });
  }

  _close() {
    _controller.forward();
    _setShow(false);
  }

  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    final _light = _theme.brightness == Brightness.light;
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
                  color: _light
                      ? const Color(0xFFD1ECFD)
                      : _theme.primaryColorDark,
                ),
                child: Row(
                  children: [
                    Text(
                      widget.tip ?? 'This panel for User Tip',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: _light
                            ? const Color(0xFF243586)
                            : const Color(0xFFFFFFFF),
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
                                color: _light
                                    ? const Color(0xFFE2F4FE)
                                    : _theme.primaryColorLight,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.close,
                                color: _light
                                    ? const Color(0xFF5A6FE8)
                                    : const Color(0xFFFFFFFF),
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
    final _light = _theme.brightness == Brightness.light;
    return Stack(
      children: [
        SlideTransition(
          position: _tween.animate(_controller),
          child: Container(
            width: Adapt.px(160),
            height: Adapt.px(80),
            margin: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border:
                  _light ? null : Border.all(color: _theme.primaryColorDark),
              color: _theme.cardColor,
              boxShadow: [
                BoxShadow(
                  blurRadius: 8,
                  spreadRadius: -3,
                  color: _light ? Color(0xFFD0D0D0) : Colors.transparent,
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Row(
            children: [
              _TabCell(
                title: I18n.of(context).account,
                selected: widget.currentIndex == 0,
                index: 0,
                onTap: _onTap,
              ),
              _TabCell(
                title: I18n.of(context).settings,
                selected: widget.currentIndex == 1,
                index: 1,
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
      fontSize: Adapt.px(28),
      fontWeight: FontWeight.w500,
    );
    final _unSelectedStyle = TextStyle(
      fontSize: Adapt.px(28),
      fontWeight: FontWeight.w500,
      color: const Color(0xFFBEBEBE),
    );
    return InkWell(
      onTap: () => onTap(index),
      child: Container(
        width: Adapt.px(160),
        height: Adapt.px(80),
        margin: EdgeInsets.symmetric(horizontal: 5),
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
  final ViewService viewService;
  const _FeaturesPanel({this.index, this.dispatch, this.viewService});
  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return viewService.buildComponent('userData');
      case 1:
        return viewService.buildComponent('settings');
      default:
        return SliverToBoxAdapter();
    }
  }
}
