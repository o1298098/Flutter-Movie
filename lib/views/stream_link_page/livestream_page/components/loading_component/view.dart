import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';

import 'state.dart';

Widget buildView(
    LoadingState state, Dispatch dispatch, ViewService viewService) {
  return state.loading ? _LoadingCell() : SizedBox();
}

class _LoadingCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0x33000000),
        child: Center(
            child: Container(
          width: Adapt.px(300),
          height: Adapt.px(300),
          decoration: BoxDecoration(
              color: Color(0xAA000000),
              borderRadius: BorderRadius.circular(Adapt.px(20))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: Adapt.px(80),
                height: Adapt.px(80),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Color(0xFFFFFFFF)),
                ),
              ),
              SizedBox(
                height: Adapt.px(30),
              ),
              Text(
                'loading Ad...',
                style: TextStyle(color: Color(0xFFFFFFFF)),
              )
            ],
          ),
        )));
  }
}
