import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/customwidgets/sliverappbardelegate.dart';
import 'package:movie/generated/i18n.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    HomePageState state, Dispatch dispatch, ViewService viewService) {
      SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarBrightness: Brightness.dark));
  Widget _buildTitle(String title, void buttonTap(),
      {IconData d = Icons.more_vert}) {
    return Padding(
      padding: EdgeInsets.all(Adapt.px(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                color: Colors.black,
                fontSize: Adapt.px(45),
                fontWeight: FontWeight.w700),
          ),
          IconButton(
            padding: EdgeInsets.only(right: 0),
            alignment: Alignment.centerRight,
            icon: Icon(d),
            onPressed: () => buttonTap(),
          )
        ],
      ),
    );
  }

  return SafeArea(
    child: CustomScrollView(
      controller: state.scrollController,
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
              _buildTitle(I18n.of(viewService.context).inTheaters, () {}),
              viewService.buildComponent('moviecells'),
              _buildTitle(I18n.of(viewService.context).onTV, () {}),
              viewService.buildComponent('tvcells'),
              Padding(
                padding: EdgeInsets.all(Adapt.px(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      I18n.of(viewService.context).popular,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: Adapt.px(45),
                          fontWeight: FontWeight.w700),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    GestureDetector(
                      onTap: () => dispatch(
                          HomePageActionCreator.onPopularFilterChanged(true)),
                      child: Text(I18n.of(viewService.context).movies,
                          style: TextStyle(
                              color: state.showmovie
                                  ? Colors.black
                                  : Colors.grey)),
                    ),
                    SizedBox(
                      width: Adapt.px(20),
                    ),
                    GestureDetector(
                      onTap: () => dispatch(
                          HomePageActionCreator.onPopularFilterChanged(false)),
                      child: Text(I18n.of(viewService.context).tvShows,
                          style: TextStyle(
                              color: state.showmovie
                                  ? Colors.grey
                                  : Colors.black)),
                    )
                  ],
                ),
              ),
              viewService.buildComponent('popular'),
              Container(height: Adapt.px(80),)
            ],
          ),
        )
      ],
    ),
  );
}
