import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/generated/i18n.dart';

import '../../action.dart';
import 'action.dart';
import 'state.dart';

Widget buildView(
    Theme2State state, Dispatch dispatch, ViewService viewService) {
  Widget _buildStyle2TapCell(String name, void ontap()) {
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(
          Adapt.px(30), Adapt.px(10), Adapt.px(30), Adapt.px(10)),
      title: Text(name,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: Adapt.px(35))),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: ontap,
    );
  }

  Widget _buildbody() {
    var _headerPadding = Adapt.px(30);
    var _headerWidth = Adapt.screenW() - 2 * _headerPadding;

    return Container(
        key: ValueKey('theme2'),
        child: SafeArea(
            child: Column(
          children: <Widget>[
            SizedBox(height: Adapt.px(30)),
            Stack(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.symmetric(horizontal: _headerPadding),
                    height: _headerWidth * 0.6,
                    width: _headerWidth,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Adapt.px(20)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.grey[300],
                              blurRadius: Adapt.px(10),
                              offset: Offset(0, Adapt.px(5)))
                        ],
                        gradient: LinearGradient(
                            tileMode: TileMode.clamp,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: <Color>[
                              //Color(0xFF3198FE),
                              //Color(0xFF38EBE2),
                              Color(0xFF5B247A),
                              Color(0xFF1BCEDF),
                            ],
                            stops: <double>[
                              0,
                              1.0,
                            ])),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: Adapt.px(80)),
                        Container(
                          width: Adapt.px(180),
                          height: Adapt.px(180),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      state.avatar ??
                                          'https://en.gravatar.com/userimage/159547793/1e81c1798f922e37511065a9c301fed9.jpg?size=200',
                                      errorListener: () {}),
                                  fit: BoxFit.cover),
                              border: Border.all(
                                  width: Adapt.px(8), color: Colors.white),
                              color: Colors.grey,
                              borderRadius:
                                  BorderRadius.circular(Adapt.px(90))),
                        ),
                        SizedBox(height: Adapt.px(30)),
                        Text(state.name,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: Adapt.px(40),
                                fontWeight: FontWeight.w600)),
                      ],
                    )),
                Container(
                    height: _headerWidth * 0.6,
                    margin: EdgeInsets.symmetric(horizontal: Adapt.px(20)),
                    alignment: Alignment.topRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          onPressed: () =>
                              dispatch(AccountPageActionCreator.themeChange()),
                          icon: Icon(
                            Icons.track_changes,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            if (state.islogin)
                              dispatch(AccountPageActionCreator.onLogout());
                            else
                              dispatch(AccountPageActionCreator.onLogin());
                          },
                          icon: Icon(
                            state.islogin
                                ? Icons.exit_to_app
                                : Icons.person_outline,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ))
              ],
            ),
            SizedBox(height: Adapt.px(50)),
            Container(
                margin: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Adapt.px(10)),
                    color: Colors.white,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.grey[300],
                          blurRadius: Adapt.px(10),
                          offset: Offset(0, Adapt.px(5)))
                    ]),
                child: Column(
                  children: <Widget>[
                    _buildStyle2TapCell(
                        I18n.of(viewService.context).watchlist,
                        () => dispatch(AccountPageActionCreator.navigatorPush(
                            'WatchlistPage',
                            arguments: {'accountid': state.acountIdV3}))),
                    Divider(height: Adapt.px(1)),
                    _buildStyle2TapCell(
                        I18n.of(viewService.context).lists,
                        () => dispatch(AccountPageActionCreator.navigatorPush(
                            'MyListsPage',
                            arguments: {'accountid': state.acountIdV4}))),
                    Divider(height: Adapt.px(1)),
                    _buildStyle2TapCell(
                        I18n.of(viewService.context).favorites,
                        () => dispatch(AccountPageActionCreator.navigatorPush(
                            'FavoritesPage',
                            arguments: {'accountid': state.acountIdV3}))),
                    Divider(height: Adapt.px(1)),
                    _buildStyle2TapCell(
                        I18n.of(viewService.context).recommendations, () {}),
                    Divider(height: Adapt.px(1)),
                    _buildStyle2TapCell(
                        I18n.of(viewService.context).ratingsReviews, () {}),
                  ],
                )),
          ],
        )));
  }

  return _buildbody();
}
