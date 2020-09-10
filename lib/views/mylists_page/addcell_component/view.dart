import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/views/mylists_page/action.dart';

import 'state.dart';

Widget buildView(
    AddCellState state, Dispatch dispatch, ViewService viewService) {
  return SliverToBoxAdapter(
      child: SizeTransition(
    sizeFactor: Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(curve: Curves.ease, parent: state.animationController)),
    child: InkWell(
      onTap: () => dispatch(MyListsPageActionCreator.createList()),
      child: Container(
        margin: EdgeInsets.only(
            top: Adapt.px(20), left: Adapt.px(20), right: Adapt.px(20)),
        height: Adapt.px(400),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 2),
            borderRadius: BorderRadius.circular(Adapt.px(20))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.add,
              size: Adapt.px(50),
            ),
            SizedBox(
              width: Adapt.px(20),
            ),
            Text(
              'Create new list',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: Adapt.px(35)),
            )
          ],
        ),
      ),
    ),
  ));
}
