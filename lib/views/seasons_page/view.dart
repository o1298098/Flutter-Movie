import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/style/themestyle.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    SeasonsPageState state, Dispatch dispatch, ViewService viewService) {
  final Random random = Random(DateTime.now().millisecondsSinceEpoch);

  Widget _buildCell(int index) {
    var d = state.seasons[index];
    var curve = CurvedAnimation(
      parent: state.animationController,
      curve: Interval(
        index * (1.0 / state.seasons.length),
        (index + 1) * (1.0 / state.seasons.length),
        curve: Curves.ease,
      ),
    );
    return SlideTransition(
        position: Tween(begin: Offset(0, 1), end: Offset.zero).animate(curve),
        child: FadeTransition(
          opacity: Tween<double>(begin: 0.0, end: 1.0).animate(curve),
          child: Padding(
            padding: EdgeInsets.only(bottom: Adapt.px(20)),
            child: GestureDetector(
              onTap: () => dispatch(SeasonsPageActionCreator.onCellTapped(
                  state.tvid, d.seasonNumber, d.name, d.posterPath)),
              child: Card(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: Adapt.px(225),
                      height: Adapt.px(380),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(
                              random.nextInt(255),
                              random.nextInt(255),
                              random.nextInt(255),
                              random.nextDouble()),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: CachedNetworkImageProvider(
                                  d.posterPath == null
                                      ? ImageUrl.emptyimage
                                      : ImageUrl.getUrl(
                                          d.posterPath, ImageSize.w300)))),
                    ),
                    SizedBox(
                      width: Adapt.px(20),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: Adapt.px(20),
                        ),
                        Container(
                          width: Adapt.screenW() - Adapt.px(320),
                          child: Text(
                            d.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Adapt.px(30)),
                          ),
                        ),
                        SizedBox(
                          height: Adapt.px(5),
                        ),
                        Text('Air Date: ${d.airDate}'),
                        SizedBox(
                          height: Adapt.px(5),
                        ),
                        Text('Episode Count: ${d.episodeCount}'),
                        SizedBox(
                          height: Adapt.px(10),
                        ),
                        Container(
                          width: Adapt.screenW() - Adapt.px(320),
                          child: Text(
                            d.overview == null || d.overview == ''
                                ? 'No overview have been added'
                                : d.overview,
                            maxLines: 6,
                            overflow: TextOverflow.ellipsis,
                            //style: TextStyle(height: 1.2),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  return Builder(builder: (context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Scaffold(
      appBar: AppBar(
        brightness: _theme.brightness,
        backgroundColor: _theme.backgroundColor,
        iconTheme: _theme.iconTheme,
        title: Text(
          'All Seasons',
          style: _theme.textTheme.body1,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Adapt.px(20)),
        child: ListView.builder(
          itemCount: state.seasons.length,
          itemBuilder: (ctx, index) {
            return _buildCell(index);
          },
        ),
      ),
    );
  });
}
