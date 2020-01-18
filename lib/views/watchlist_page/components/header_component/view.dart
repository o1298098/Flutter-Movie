import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/generated/i18n.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    HeaderState state, Dispatch dispatch, ViewService viewService) {
  final TextStyle _selectTextStyle =
      TextStyle(fontSize: Adapt.px(45), fontWeight: FontWeight.bold);
  final TextStyle _unselectTextStyle =
      TextStyle(fontSize: Adapt.px(30), fontWeight: FontWeight.bold);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          InkWell(
            onTap: () {
              if (!state.isMovie) {
                dispatch(HeaderActionCreator.widthChanged(true));
                state.animationController.reverse();
              }
            },
            child: Container(
              alignment: Alignment.bottomCenter,
              height: Adapt.px(60),
              width: Adapt.px(250),
              child: Text(
                I18n.of(viewService.context).movies,
                style: state.isMovie ? _selectTextStyle : _unselectTextStyle,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              if (state.isMovie) {
                dispatch(HeaderActionCreator.widthChanged(false));
                state.animationController.forward(from: 0.0);
              }
            },
            child: Container(
                alignment: Alignment.bottomCenter,
                height: Adapt.px(60),
                width: Adapt.px(250),
                child: Text(
                  I18n.of(viewService.context).tvShows,
                  style: state.isMovie ? _unselectTextStyle : _selectTextStyle,
                )),
          ),
          Expanded(
            child: Container(),
          ),
          Container(
            width: Adapt.px(50),
            height: Adapt.px(50),
            decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(Adapt.px(10))),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.of(viewService.context).pop(),
            ),
          ),
          SizedBox(
            width: Adapt.px(30),
          )
        ],
      ),
      SizedBox(
        height: Adapt.px(10),
      ),
      Container(
        alignment: Alignment.centerLeft,
        width: Adapt.px(500),
        child: SlideTransition(
          position: Tween(begin: Offset.zero, end: Offset(1, 0)).animate(
              CurvedAnimation(
                  curve: Curves.ease, parent: state.animationController)),
          child: Container(
            width: Adapt.px(250),
            height: Adapt.px(20),
            decoration:
                BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
          ),
        ),
      ),
      SizedBox(height: Adapt.px(80)),
    ],
  );
}
