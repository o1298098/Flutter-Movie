import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/generated/i18n.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    AccountPageState state, Dispatch dispatch, ViewService viewService) {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarBrightness: Brightness.dark));

  Widget _buildTapCell(String name, void ontap()) {
    return GestureDetector(
      onTap: () => ontap(),
      child: Container(
        padding: EdgeInsets.all(Adapt.px(30)),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(name,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: Adapt.px(40))),
              Icon(Icons.keyboard_arrow_right),
            ]),
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
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              width: Adapt.screenW(),
              decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(Colors.black, BlendMode.color),
                  image: CachedNetworkImageProvider(
                      'https://image.tmdb.org/t/p/w500_and_h282_face/9xzZBZ5VhIIhyKDKK3t89ggx7cS.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              height: Adapt.px(450),
            ),
            Container(
              height: Adapt.px(450),
              color: Color.fromRGBO(43, 58, 66, 0.9),
            ),
            _buildHeader(),
            SafeArea(
              child:Container(
              margin: EdgeInsets.only(right: Adapt.px(20)),
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: (){
                  if(state.islogin)
                  dispatch(AccountPageActionCreator.onLogout());
                  else
                  dispatch(AccountPageActionCreator.onLogin());
                },
                icon: Icon(state.islogin?Icons.input: Icons.person,color: Colors.white,),
              ),
            ))
          ],
        ),
        _buildTapCell(I18n.of(viewService.context).watchlist, () {}),
        Divider(
          height: 1,
        ),
        _buildTapCell(I18n.of(viewService.context).lists, () {}),
        Divider(
          height: 1,
        ),
        _buildTapCell(I18n.of(viewService.context).favorites, () {}),
        Divider(
          height: 1,
        ),
        _buildTapCell(I18n.of(viewService.context).recommendations, () {}),
        Divider(
          height: 1,
        ),
        _buildTapCell(I18n.of(viewService.context).ratingsReviews, () {}),
        Divider(
          height: 1,
        ),
        
      ],
    ),
  );
}
