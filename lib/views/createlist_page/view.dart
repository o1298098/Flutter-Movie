import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/Adapt.dart';

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
            onChanged: (s) => dispatch(CreateListPageActionCreator.setName(s)),
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
            onChanged: (s) =>
                dispatch(CreateListPageActionCreator.setBackGround(s)),
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
            onChanged: (s) =>
                dispatch(CreateListPageActionCreator.setDescription(s)),
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

  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      elevation: 0.0,
      backgroundColor: Colors.white,
      title: Text(
        'CreatList',
        style: TextStyle(color: Colors.black),
      ),
    ),
    body: _buildBody(),
  );
}
