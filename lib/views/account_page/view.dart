import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie/actions/Adapt.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    AccountPageState state, Dispatch dispatch, ViewService viewService) {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarBrightness: Brightness.dark));
  return Container(
    child: Column(
      children: <Widget>[
        Container(
          width: Adapt.screenW(),
          color: Colors.teal,
          height: Adapt.px(500),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(Adapt.px(40)),
                      width: Adapt.px(150),
                      height: Adapt.px(150),
                      decoration: BoxDecoration(
                          color: Colors.teal[800],
                          borderRadius: BorderRadius.circular(Adapt.px(75))),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('o1298098',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: Adapt.px(50),
                                fontWeight: FontWeight.w600)),
                        Row(
                          children: <Widget>[
                            Text('data',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Adapt.px(40))),
                            SizedBox(
                              width: Adapt.px(30),
                            ),
                            Text('data',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Adapt.px(40),)),
                          ],
                        )
                      ],
                    ),
                    Expanded(child: Container(),),
                    IconButton(
                      iconSize: Adapt.px(60),
                      color: Colors.white,
                      icon: Icon(Icons.person),
                      onPressed:()=>dispatch(AccountPageActionCreator.onLogin()),
                      )
                  ],
                )
              ],
            ),
          ),
        ),
        Container(),
      ],
    ),
  );
}
