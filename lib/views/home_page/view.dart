import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/customwidgets/sliverappbar_delegate.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/enums/media_type.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    HomePageState state, Dispatch dispatch, ViewService viewService) {
  Widget _buildTitle(String title, void buttonTap(),
      {IconData d = Icons.more_vert}) {
    return Padding(
      padding: EdgeInsets.fromLTRB(Adapt.px(20),0,Adapt.px(20),0),
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

  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      brightness: Brightness.light,
      elevation: 0.0,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: viewService.buildComponent('searchbar'),
    ),
    body: CustomScrollView(
      controller: state.scrollController,
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildTitle(I18n.of(viewService.context).inTheaters,()=>dispatch(HomePageActionCreator.onMoreTapped(state.movie,MediaType.movie))),
              viewService.buildComponent('moviecells'),
              _buildTitle(I18n.of(viewService.context).onTV, ()=>dispatch(HomePageActionCreator.onMoreTapped(state.tv,MediaType.tv))),
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
                              fontSize: Adapt.px(24),
                              fontWeight: state.showmovie? FontWeight.bold:FontWeight.normal,
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
                             fontSize: Adapt.px(24),
                             fontWeight: state.showmovie? FontWeight.normal:FontWeight.bold,
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
