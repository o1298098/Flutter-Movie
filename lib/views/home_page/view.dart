import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/customwidgets/sliverappbardelegate.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    HomePageState state, Dispatch dispatch, ViewService viewService) {
  return SafeArea(
    child: CustomScrollView(
      slivers: <Widget>[
        SliverPersistentHeader(
          pinned: true,
          delegate: SliverAppBarDelegate(
            minHeight: Adapt.px(120),
            maxHeight: Adapt.px(120),
            child: Container(
              color: Colors.white,
              child: viewService.buildComponent('searchbar'),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(Adapt.px(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'In Theaters',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: Adapt.px(45),
                          fontWeight: FontWeight.w700),
                    ),
                    IconButton(
                      padding: EdgeInsets.only(right: 0),
                      alignment: Alignment.centerRight,
                      icon: Icon(Icons.more_vert),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
              viewService.buildComponent('moviecells'),
              Padding(
                padding: EdgeInsets.all(Adapt.px(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'On TV',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: Adapt.px(45),
                          fontWeight: FontWeight.w700),
                    ),
                    IconButton(
                      padding: EdgeInsets.only(right: 0),
                      alignment: Alignment.centerRight,
                      icon: Icon(Icons.more_vert),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
              viewService.buildComponent('tvcells'),
            ],
          ),
        )
      ],
    ),
  );
}
