import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/customwidgets/customcliper_path.dart';
import 'package:movie/generated/i18n.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    AccountPageState state, Dispatch dispatch, ViewService viewService) {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarBrightness: Brightness.dark));
  final double _cellwidth = (Adapt.screenW() - Adapt.px(90)) / 2;
  Widget _buildTapCell(String name, double begin, double end, void ontap()) {
    return SlideTransition(
      position: Tween<Offset>(begin: Offset(-1, 0), end: Offset.zero)
          .animate(CurvedAnimation(
              parent: state.animationController,
              curve: Interval(
                begin,
                end,
                curve: Curves.ease,
              ))),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(name,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: Adapt.px(40))),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: ontap,
          ),
          Divider(
            height: 1,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return SafeArea(
      child: Container(
        width: Adapt.screenW(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(Adapt.px(30)),
              width: Adapt.px(180),
              height: Adapt.px(180),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(
                          state.avatar ??
                              'https://en.gravatar.com/userimage/159547793/1e81c1798f922e37511065a9c301fed9.jpg?size=200',
                          errorListener: () {}),
                      fit: BoxFit.cover),
                  border: Border.all(width: Adapt.px(8), color: Colors.white),
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(Adapt.px(90))),
            ),
            Text(state.name,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: Adapt.px(50),
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        ClipPath(
            clipper: CustomCliperPath(
                height: Adapt.px(450),
                width: Adapt.screenW(),
                radius: Adapt.px(2000)),
            child: Stack(
              children: <Widget>[
                Container(
                    width: Adapt.screenW(),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(
                        colorFilter:
                            ColorFilter.mode(Colors.black, BlendMode.color),
                        image: CachedNetworkImageProvider(
                            'https://image.tmdb.org/t/p/w500_and_h282_face/9xzZBZ5VhIIhyKDKK3t89ggx7cS.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    height: Adapt.px(450),
                    child: Container(
                      color: Color.fromRGBO(43, 58, 66, 0.9),
                      child: _buildHeader(),
                    )),
                SafeArea(
                    child: Container(
                  margin: EdgeInsets.only(right: Adapt.px(20)),
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {
                      if (state.islogin)
                        dispatch(AccountPageActionCreator.onLogout());
                      else
                        dispatch(AccountPageActionCreator.onLogin());
                    },
                    icon: Icon(
                      state.islogin ? Icons.exit_to_app : Icons.person_outline,
                      color: Colors.white,
                    ),
                  ),
                ))
              ],
            )),
        _buildTapCell(
            I18n.of(viewService.context).watchlist,
            0,
            0.2,
            () => dispatch(AccountPageActionCreator.navigatorPush(
                'WatchlistPage',
                arguments: {'accountid': state.acountIdV3}))),
        _buildTapCell(
            I18n.of(viewService.context).lists,
            0.1,
            0.3,
            () => dispatch(AccountPageActionCreator.navigatorPush('MyListsPage',
                arguments: {'accountid': state.acountIdV4}))),
        _buildTapCell(
            I18n.of(viewService.context).favorites,
            0.2,
            0.4,
            () => dispatch(AccountPageActionCreator.navigatorPush(
                'FavoritesPage',
                arguments: {'accountid': state.acountIdV3}))),
        _buildTapCell(
            I18n.of(viewService.context).recommendations, 0.3, 0.5, () {}),
        _buildTapCell(
            I18n.of(viewService.context).ratingsReviews, 0.4, 0.6, () {}),
      ],
    ),
  );
}
