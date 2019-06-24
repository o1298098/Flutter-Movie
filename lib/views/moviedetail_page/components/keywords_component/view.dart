import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/models/keyword.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    KeyWordsState state, Dispatch dispatch, ViewService viewService) {
  Widget _buildKeyWordChip(KeyWordData k) {
    return Chip(
      elevation: 3.0,
      backgroundColor: Colors.white,
      label: Text(k.name),
    );
  }

  Widget _getKeyWordCell() {
    if (state.keywords.keywords.length == 0)
      return Container();
    else
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(Adapt.px(30)),
            child: Text('Tags',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: Adapt.px(40),
                    fontWeight: FontWeight.w800)),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(
                Adapt.px(30), 0, Adapt.px(30), Adapt.px(30)),
            child: Wrap(
              spacing: Adapt.px(15),
              direction: Axis.horizontal,
              children: state.keywords.keywords.map(_buildKeyWordChip).toList(),
            ),
          ),
        ],
      );
  }

  return _getKeyWordCell();
}
