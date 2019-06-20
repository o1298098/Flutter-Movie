import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/views/account_page/action.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    LoginPageState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.teal,
      elevation: 0.0,
    ),
    body: Container(
      color: Colors.teal,
      child: Center(
        child: Card(
          elevation: 10,
          child: Container(
            height: Adapt.px(800),
            width: Adapt.screenW() * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(Adapt.px(40)),
                  child: TextField(
                    style:
                        TextStyle(color: Colors.black, fontSize: Adapt.px(35)),
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      fillColor: Colors.transparent,
                      hintText: 'Account',
                      hasFloatingPlaceholder: true,
                      filled: true,
                      prefixStyle: TextStyle(
                          color: Colors.black, fontSize: Adapt.px(35)),
                    ),
                    onChanged: (String t)=>dispatch(LoginPageActionCreator.onAccountChange(t)),
                  ),
                ),
                 Padding(
                  padding: EdgeInsets.all(Adapt.px(40)),
                  child: TextField(
                    style:TextStyle(color: Colors.black, fontSize: Adapt.px(35)),
                    cursorColor: Colors.black,
                    obscureText: true,
                    decoration: InputDecoration(
                      fillColor: Colors.transparent,
                      hintText: 'PassWord',
                      hasFloatingPlaceholder: true,
                      filled: true,
                      prefixStyle: TextStyle(
                          color: Colors.black, fontSize: Adapt.px(35)),
                    ),
                    onChanged: (String t)=>dispatch(LoginPageActionCreator.onPwdChange(t)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: Adapt.px(60)),
                  color: Colors.teal,
                  width: Adapt.screenW()*0.8,
                  child: FlatButton(
                  child: Text('Sign In',style:TextStyle(color: Colors.white, fontSize: Adapt.px(35))),
                  onPressed: ()=>dispatch(LoginPageActionCreator.onLoginClicked()),
                ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
