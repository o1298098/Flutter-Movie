import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/widgets/backdrop.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/style/themestyle.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    HomePageState state, Dispatch dispatch, ViewService viewService) {
  return Builder(
    builder: (context) {
      final ThemeData _theme = ThemeStyle.getTheme(context);
      return Scaffold(
        appBar: AppBar(
          backgroundColor: _theme.bottomAppBarColor,
          brightness: Brightness.dark,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          title: _SearchBar(
            onTap: () => dispatch(HomePageActionCreator.onSearchBarTapped()),
          ),
        ),
        body: BackDrop(
          backLayerHeight: Adapt.px(580) + Adapt.padTopH(),
          backChild: viewService.buildComponent('header'),
          frontBackGroundColor: _theme.backgroundColor,
          frontChildren: <Widget>[
            const _Line(),
            viewService.buildComponent('swiper'),
            viewService.buildComponent('trending'),
            viewService.buildComponent('share'),
            viewService.buildComponent('popularposter'),
          ],
        ),
      );
    },
  );
}

class _SearchBar extends StatelessWidget {
  final Function onTap;
  const _SearchBar({this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: Adapt.px(30), right: Adapt.px(30)),
        height: Adapt.px(70),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Adapt.px(40)),
          color: const Color.fromRGBO(57, 57, 57, 1),
        ),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.search,
              color: Colors.grey,
            ),
            SizedBox(width: Adapt.px(20)),
            SizedBox(
              width: Adapt.screenW() - Adapt.px(200),
              child: Text(
                I18n.of(context).searchbartxt,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey, fontSize: Adapt.px(28)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Line extends StatelessWidget {
  const _Line({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Center(
        child: Container(
          width: 40,
          height: 3,
          color: _theme.primaryColorDark,
        ),
      ),
    );
  }
}
