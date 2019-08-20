import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/enums/imagesize.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(WatchlistDetailPageState state, Dispatch dispatch,
    ViewService viewService) {
  Widget _buildColumnCell(String value, String title,
      {double start = 0.0, double end = 1.0}) {
    var curve = Curves.ease;
    var position = Tween(begin: Offset(0, 0.8), end: Offset.zero).animate(
        CurvedAnimation(
            parent: state.animationController,
            curve: Interval(start, end, curve: curve)));
    var opacity = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: state.animationController,
        curve: Interval(start, end, curve: curve)));
    return SlideTransition(
        position: position,
        child: Opacity(
            opacity: opacity.value,
            child: Column(
              children: <Widget>[
                Text(
                  value,
                  style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: Adapt.px(45),
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  title,
                  style: TextStyle(color: Colors.grey[700]),
                )
              ],
            )));
  }

  Widget _buildInfo() {
    var _d = state.mediaData;
    var curve = Curves.ease;
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
        child: AnimatedBuilder(
          animation: state.animationController,
          builder: (context, child) {
            var titlePosition = Tween(begin: Offset(0, 1.0), end: Offset.zero)
                .animate(CurvedAnimation(
                    parent: state.animationController,
                    curve: Interval(0, 0.3, curve: curve)));
            var titleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                    parent: state.animationController,
                    curve: Interval(0, 0.3, curve: curve)));
            var owPosition = Tween(begin: Offset(0, 0.2), end: Offset.zero)
                .animate(CurvedAnimation(
                    parent: state.animationController,
                    curve: Interval(0.3, 0.6, curve: curve)));
            var owOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                    parent: state.animationController,
                    curve: Interval(0.3, 0.6, curve: curve)));
            return Container(
              child: Column(
                children: <Widget>[
                  SlideTransition(
                    position: titlePosition,
                    child: Opacity(
                      opacity: titleOpacity.value,
                      child: Container(
                        child: Text(
                          _d.title ?? _d.name,
                          maxLines: 1,
                          style: TextStyle(
                              color: Color(0xFF333333),
                              fontSize: Adapt.px(50),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Adapt.px(60),
                  ),
                  SlideTransition(
                      position: owPosition,
                      child: Opacity(
                          opacity: owOpacity.value,
                          child: Text(
                            _d.overview,
                            maxLines: 3,
                          ))),
                  SizedBox(
                    height: Adapt.px(60),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      _buildColumnCell(
                          _d.vote_average.toStringAsFixed(1), 'Score',
                          start: 0.6, end: 0.8),
                      Opacity(
                          opacity: Tween(begin: 0.0, end: 1.0)
                              .animate(CurvedAnimation(
                                  parent: state.animationController,
                                  curve: Interval(0.7, 0.8, curve: curve)))
                              .value,
                          child: Container(
                            width: Adapt.px(3),
                            height: Adapt.px(60),
                            color: Colors.grey[200],
                          )),
                      SlideTransition(
                          position: owPosition,
                          child: Opacity(
                              opacity: owOpacity.value,
                              child: _buildColumnCell(
                                  _d.vote_count.toString(), 'Rated',
                                  start: 0.7, end: 0.9))),
                      Opacity(
                          opacity: Tween(begin: 0.0, end: 1.0)
                              .animate(CurvedAnimation(
                                  parent: state.animationController,
                                  curve: Interval(0.8, 0.9, curve: curve)))
                              .value,
                          child: Opacity(
                              opacity: owOpacity.value,
                              child: Container(
                                width: Adapt.px(3),
                                height: Adapt.px(60),
                                color: Colors.grey[200],
                              ))),
                      SlideTransition(
                          position: owPosition,
                          child: Opacity(
                              opacity: owOpacity.value,
                              child: _buildColumnCell(
                                  _d.popularity.toStringAsFixed(0), 'Popular',
                                  start: 0.8, end: 1.0))),
                    ],
                  ),
                ],
              ),
            );
          },
        ));
  }

  return Scaffold(
    body: Container(
      child: Column(
        children: <Widget>[
          Hero(
            tag: 'Background${state.mediaData.id}',
            child: Material(
                child: Container(
              height: Adapt.screenH() / 2 + Adapt.px(120),
              alignment: Alignment.bottomRight,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  image: DecorationImage(
                      alignment: Alignment.bottomCenter,
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(ImageUrl.getUrl(
                          state.mediaData.poster_path, ImageSize.w500))),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        blurRadius: 20,
                        offset: Offset(-5, 12),
                        color: Colors.black26)
                  ],
                  borderRadius: BorderRadius.circular(Adapt.px(50))),
            )),
          ),
          SizedBox(
            height: Adapt.px(80),
          ),
          _buildInfo(),
          Expanded(
            child: Container(),
          ),
          Container(
            width: Adapt.px(120),
            height: Adapt.px(120),
            decoration:
                BoxDecoration(color: Colors.teal[200], shape: BoxShape.circle),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.arrow_back,
                size: Adapt.px(50),
                color: Colors.white,
              ),
              onPressed: () async {
                state.animationController.reverse().then((f) {
                  Navigator.of(viewService.context).pop();
                });
              },
            ),
          ),
          SizedBox(
            height: Adapt.px(40),
          ),
        ],
      ),
    ),
  );
}
