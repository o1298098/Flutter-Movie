import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/views/detail_page/action.dart';

import 'state.dart';

Widget buildView(
    AppBarState state, Dispatch dispatch, ViewService viewService) {
  return Positioned(
    left: 0,
    right: 0,
    top: 0,
    child: _CustomAppBar(
      title: state.title ?? '',
      controller: state.scrollController,
      menuPress: () => dispatch(MovieDetailPageActionCreator.openMenu()),
    ),
  );
}

class _CustomAppBar extends StatefulWidget {
  final ScrollController controller;
  final String title;
  final Function menuPress;
  const _CustomAppBar({this.controller, this.title, this.menuPress});
  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<_CustomAppBar> {
  bool showBar = false;
  double _opacity = 0.0;
  final double _opacityHeight = Adapt.px(300);
  final double _appBarChangeHeight = Adapt.px(600);
  final double _totalHeight = Adapt.px(900);
  void _checkTitle() {
    if (widget.controller.position.pixels >= _appBarChangeHeight) {
      double v =
          _opacityHeight - (_totalHeight - widget.controller.position.pixels);
      v = v > _opacityHeight || v < 0 ? _opacityHeight : v;
      _opacity = v / _opacityHeight;
      showBar = true;
    } else {
      showBar = false;
    }
    setState(() {});
  }

  @override
  void initState() {
    widget.controller.addListener(_checkTitle);
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_checkTitle);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    return showBar
        ? AppBar(
            key: ValueKey('AppBarShow'),
            backgroundColor: _theme.backgroundColor.withOpacity(_opacity),
            brightness: _theme.brightness,
            iconTheme: _theme.iconTheme,
            title: Text(
              widget.title,
              style: TextStyle(color: _theme.textTheme.bodyText1.color),
            ),
            actions: [
              IconButton(
                onPressed: widget.menuPress,
                icon: Icon(Icons.more_vert),
              )
            ],
          )
        : AppBar(
            key: ValueKey('AppBarHide'),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: InkWell(
              child: Container(
                margin: EdgeInsets.all(Adapt.px(22)),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: const Color(0x60000000)),
                child: Icon(
                  Icons.keyboard_arrow_left,
                  size: Adapt.px(40),
                  color: const Color(0xFFFFFFFF),
                ),
              ),
              onTap: () => Navigator.of(context).pop(),
            ),
            actions: [
              InkWell(
                child: Container(
                  margin: EdgeInsets.all(Adapt.px(22)),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: const Color(0x60000000)),
                  child: Icon(
                    Icons.more_vert,
                    size: Adapt.px(40),
                    color: const Color(0xFFFFFFFF),
                  ),
                ),
                onTap: widget.menuPress,
              )
            ],
          );
  }
}
