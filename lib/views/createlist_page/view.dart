import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/style/themestyle.dart';

import '../../style/themestyle.dart';
import 'action.dart';
import 'state.dart';

Widget buildView(
    CreateListPageState state, Dispatch dispatch, ViewService viewService) {
  Widget _buildBody() {
    return Container(
      padding: EdgeInsets.all(Adapt.px(30)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: state.nameTextController,
            cursorColor: Colors.grey,
            decoration: InputDecoration(
              enabled: state.listData == null,
              border: OutlineInputBorder(),
              labelText: 'ListName',
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
            ),
          ),
          SizedBox(
            height: Adapt.px(30),
          ),
          TextField(
            controller: state.backGroundTextController,
            cursorColor: Colors.grey,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'BackGroundUrl',
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
            ),
          ),
          SizedBox(
            height: Adapt.px(30),
          ),
          TextField(
            controller: state.descriptionTextController,
            maxLines: 18,
            cursorColor: Colors.grey,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'description',
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey))),
          ),
          SizedBox(
            height: Adapt.px(30),
          ),
          Container(
            width: Adapt.screenW(),
            decoration: BoxDecoration(
              color: Color(0xFF505050),
              borderRadius: BorderRadius.circular(Adapt.px(20)),
            ),
            child: FlatButton(
              onPressed: () => dispatch(CreateListPageActionCreator.onSubmit()),
              child: Text(
                'Submit',
                style: TextStyle(color: Colors.white, fontSize: Adapt.px(28)),
              ),
            ),
          )
        ],
      ),
    );
  }

  return Builder(builder: (context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Scaffold(
      backgroundColor: _theme.backgroundColor,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        iconTheme: _theme.iconTheme,
        elevation: 0.0,
        backgroundColor: _theme.backgroundColor,
        title: Text(
          'CreatList',
          style: _theme.textTheme.body1,
        ),
      ),
      body: _buildBody(),
    );
  });
}
