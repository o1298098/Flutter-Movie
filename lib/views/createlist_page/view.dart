import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/models/base_api_model/user_list.dart';
import 'package:movie/style/themestyle.dart';

import '../../style/themestyle.dart';
import 'action.dart';
import 'state.dart';

Widget buildView(
    CreateListPageState state, Dispatch dispatch, ViewService viewService) {
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
          style: _theme.textTheme.bodyText1,
        ),
      ),
      body: _Body(
        backGroundTextController: state.backGroundTextController,
        descriptionTextController: state.descriptionTextController,
        listData: state.listData,
        nameTextController: state.nameTextController,
        dispatch: dispatch,
      ),
    );
  });
}

class _Body extends StatelessWidget {
  final TextEditingController nameTextController;
  final TextEditingController backGroundTextController;
  final TextEditingController descriptionTextController;
  final UserList listData;
  final Dispatch dispatch;
  _Body({
    this.backGroundTextController,
    this.descriptionTextController,
    this.dispatch,
    this.listData,
    this.nameTextController,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Adapt.px(30)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: nameTextController,
            cursorColor: Colors.grey,
            decoration: InputDecoration(
              enabled: listData == null,
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
            controller: backGroundTextController,
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
            controller: descriptionTextController,
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
}
