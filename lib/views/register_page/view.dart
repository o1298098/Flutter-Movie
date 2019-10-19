import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/Adapt.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    RegisterPageState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppBar(),
    body: Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            focusNode: state.nameFocusNode,
            decoration: InputDecoration(
                fillColor: Colors.transparent,
                hintText: 'Nickname',
                hasFloatingPlaceholder: true,
                filled: true,
                prefixStyle:
                    TextStyle(color: Colors.black, fontSize: Adapt.px(35)),
                focusedBorder: new UnderlineInputBorder(
                    borderSide: new BorderSide(color: Colors.black87))),
            validator: (String value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onChanged: (t) =>
                dispatch(RegisterPageActionCreator.onNameTextChanged(t)),
          ),
          TextFormField(
            focusNode: state.emailFocusNode,
            decoration: InputDecoration(
                fillColor: Colors.transparent,
                hintText: 'Email',
                hasFloatingPlaceholder: true,
                filled: true,
                prefixStyle:
                    TextStyle(color: Colors.black, fontSize: Adapt.px(35)),
                focusedBorder: new UnderlineInputBorder(
                    borderSide: new BorderSide(color: Colors.black87))),
            validator: (String value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onChanged: (t) =>
                dispatch(RegisterPageActionCreator.onEmailTextChanged(t)),
          ),
          TextFormField(
            focusNode: state.pwdFocusNode,
            decoration: InputDecoration(
                fillColor: Colors.transparent,
                hintText: 'Password',
                hasFloatingPlaceholder: true,
                filled: true,
                prefixStyle:
                    TextStyle(color: Colors.black, fontSize: Adapt.px(35)),
                focusedBorder: new UnderlineInputBorder(
                    borderSide: new BorderSide(color: Colors.black87))),
            validator: (String value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onChanged: (t) =>
                dispatch(RegisterPageActionCreator.onPwdTextChanged(t)),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            alignment: Alignment.center,
            child: RaisedButton(
              onPressed: () =>
                  dispatch(RegisterPageActionCreator.onRegisterWithEmail()),
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    ),
  );
}
