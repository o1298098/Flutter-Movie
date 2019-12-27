import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/models/enums/streamlink_type.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    AddLinkPageState state, Dispatch dispatch, ViewService viewService) {
  Widget _buildBody() {
    return Container(
      padding: EdgeInsets.all(Adapt.px(30)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: state.linkNameTextController,
            cursorColor: Colors.grey,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'LinkName',
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
            ),
            onChanged: (s) => dispatch(AddLinkPageActionCreator.setLinkName(s)),
          ),
          SizedBox(
            height: Adapt.px(30),
          ),
          TextField(
            controller: state.streamLinkTextController,
            maxLines: 18,
            cursorColor: Colors.grey,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Stream Link',
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey))),
            onChanged: (s) =>
                dispatch(AddLinkPageActionCreator.setStreamLink(s)),
          ),
          SizedBox(
            height: Adapt.px(30),
          ),
          Row(
            children: <Widget>[
              Radio(
                value: StreamLinkType.other,
                groupValue: state.streamLinkType,
                activeColor: Color(0xFF505050),
                onChanged: (s) =>
                    dispatch(AddLinkPageActionCreator.streamLinkTypeChanged(s)),
              ),
              Text('other'),
              SizedBox(width: Adapt.px(20)),
              Radio(
                value: StreamLinkType.youtube,
                groupValue: state.streamLinkType,
                activeColor: Color(0xFF505050),
                onChanged: (s) =>
                    dispatch(AddLinkPageActionCreator.streamLinkTypeChanged(s)),
              ),
              Text('YouTube embed'),
            ],
          ),
          SizedBox(height: Adapt.px(30)),
          Container(
            width: Adapt.screenW(),
            decoration: BoxDecoration(
              color: Color(0xFF505050),
              borderRadius: BorderRadius.circular(Adapt.px(20)),
            ),
            child: FlatButton(
              onPressed: () => dispatch(AddLinkPageActionCreator.submit()),
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
    resizeToAvoidBottomPadding: false,
    appBar: AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      elevation: 0.0,
      title: Text(
        state.name,
        style: TextStyle(color: Colors.black),
      ),
    ),
    body: _buildBody(),
  );
}
