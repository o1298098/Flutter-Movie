import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/enums/media_type.dart';
import 'package:movie/models/video_list.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    MoreMediaPageState state, Dispatch dispatch, ViewService viewService) {
  Random random = Random(DateTime.now().millisecondsSinceEpoch);

  Widget _buildCell(VideoListResult d) {
    int index = state.videoList.results.indexOf(d);
    double w = Adapt.screenW() / 2;
    double h = w * 1.5;
    var curve = CurvedAnimation(
      parent: state.animationController,
      curve: Interval(
        index * (1.0 / state.videoList.results.length),
        (index + 1) * (1.0 / state.videoList.results.length),
        curve: Curves.ease,
      ),
    );
    return SlideTransition(
      position: Tween(begin: Offset(0, 1), end: Offset.zero).animate(curve),
      child: FadeTransition(
        opacity: Tween<double>(begin: 0.0, end: 1.0).animate(curve),
        child: GestureDetector(
          onTap: () => dispatch(MoreMediaPageActionCreator.cellTapped(
              d.id, d.title ?? d.name, d.backdropPath, d.posterPath)),
          child: Container(
            alignment: Alignment.bottomLeft,
            width: w,
            height: h,
            padding: EdgeInsets.all(Adapt.px(10)),
            decoration: BoxDecoration(
                color: Color.fromRGBO(random.nextInt(255), random.nextInt(255),
                    random.nextInt(255), random.nextDouble()),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(d.posterPath == null
                        ? ImageUrl.emptyimage
                        : ImageUrl.getUrl(d.posterPath, ImageSize.w300)))),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.topRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.star,
                        color: Colors.white,
                        size: Adapt.px(30),
                      ),
                      SizedBox(
                        width: Adapt.px(5),
                      ),
                      Text(
                        d.voteAverage.toStringAsFixed(1),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: Adapt.px(30),
                            shadows: <Shadow>[
                              Shadow(
                                  blurRadius: 2,
                                  //offset: Offset(Adapt.px(1),Adapt.px(1)),
                                  color: Colors.black87)
                            ]),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: w - Adapt.px(10) * 2,
                      child: Text(d.title ?? d.name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: Adapt.px(30),
                              fontWeight: FontWeight.bold,
                              shadows: <Shadow>[
                                Shadow(
                                    blurRadius: 3,
                                    //offset: Offset(Adapt.px(1),Adapt.px(1)),
                                    color: Colors.black87)
                              ])),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          state.mediaType == MediaType.movie
              ? I18n.of(viewService.context).inTheaters
              : I18n.of(viewService.context).onTV,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: CustomScrollView(
        controller: state.scrollController,
        slivers: <Widget>[
          SliverGrid.extent(
              childAspectRatio: 2 / 3,
              maxCrossAxisExtent: Adapt.screenW() / 2,
              children: state.videoList.results.map(_buildCell).toList()),
          SliverToBoxAdapter(
            child: Offstage(
              offstage: state.videoList.results.length ==
                  state.videoList.totalResults,
              child: Container(
                height: Adapt.px(120),
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.black),
                ),
              ),
            ),
          )
        ],
      ));
}
