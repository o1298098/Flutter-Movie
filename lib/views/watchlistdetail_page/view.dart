import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/base_api_model/user_media.dart';
import 'package:movie/models/enums/imagesize.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(WatchlistDetailPageState state, Dispatch dispatch,
    ViewService viewService) {
  return Scaffold(
    body: Container(
      child: Column(
        children: <Widget>[
          Hero(
            tag: 'Background${state.mediaData.mediaId}',
            child: Material(
              child: GestureDetector(
                onTap: () =>
                    dispatch(WatchlistDetailPageActionCreator.meidaTap()),
                child: Container(
                  height: Adapt.screenH() / 2 + Adapt.px(120),
                  alignment: Alignment.bottomRight,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    image: DecorationImage(
                      alignment: Alignment.bottomCenter,
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                        ImageUrl.getUrl(
                            state.mediaData.photoUrl, ImageSize.w500),
                      ),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          blurRadius: 20,
                          offset: Offset(-5, 12),
                          color: Colors.black26)
                    ],
                    borderRadius: BorderRadius.circular(
                      Adapt.px(50),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: Adapt.px(80),
          ),
          _Info(
            mediaData: state.mediaData,
            animationController: state.animationController,
          ),
          Expanded(child: SizedBox()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.teal[200], shape: BoxShape.circle),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.arrow_back,
                    size: Adapt.px(50),
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    state.animationController.reverse().then((f) {
                      Future.delayed(Duration(milliseconds: 80), () {
                        Navigator.of(viewService.context).pop();
                      });
                    });
                  },
                ),
              ),
              SizedBox(width: 20),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.orangeAccent[400], shape: BoxShape.circle),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.more_vert_outlined,
                    size: Adapt.px(50),
                    color: Colors.white,
                  ),
                  onPressed: () =>
                      dispatch(WatchlistDetailPageActionCreator.meidaTap()),
                ),
              ),
            ],
          ),
          SizedBox(height: Adapt.px(40)),
        ],
      ),
    ),
  );
}

class _ColumnCell extends StatelessWidget {
  final AnimationController animationController;
  final double start;
  final double end;
  final String title;
  final String value;
  const _ColumnCell({
    this.animationController,
    this.end,
    this.start,
    this.title,
    this.value,
  });
  @override
  Widget build(BuildContext context) {
    final curve = Curves.ease;
    final position = Tween(begin: Offset(0, 0.8), end: Offset.zero).animate(
        CurvedAnimation(
            parent: animationController,
            curve: Interval(start, end, curve: curve)));
    final opacity = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
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
                  fontSize: Adapt.px(45), fontWeight: FontWeight.bold),
            ),
            Text(
              title,
            )
          ],
        ),
      ),
    );
  }
}

class _Info extends StatelessWidget {
  final AnimationController animationController;
  final UserMedia mediaData;
  const _Info({this.animationController, this.mediaData});
  @override
  Widget build(BuildContext context) {
    final _d = mediaData;
    final curve = Curves.ease;
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
        child: AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            var titlePosition = Tween(begin: Offset(0, 1.0), end: Offset.zero)
                .animate(CurvedAnimation(
                    parent: animationController,
                    curve: Interval(0, 0.3, curve: curve)));
            var titleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                    parent: animationController,
                    curve: Interval(0, 0.3, curve: curve)));
            var owPosition = Tween(begin: Offset(0, 0.2), end: Offset.zero)
                .animate(CurvedAnimation(
                    parent: animationController,
                    curve: Interval(0.3, 0.6, curve: curve)));
            var owOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                    parent: animationController,
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
                          _d.name,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: Adapt.px(45),
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
                            _d.overwatch,
                            maxLines: 3,
                          ))),
                  SizedBox(
                    height: Adapt.px(60),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      _ColumnCell(
                        value: _d.rated.toString(),
                        title: 'Score',
                        start: 0.6,
                        end: 0.8,
                        animationController: animationController,
                      ),
                      Opacity(
                          opacity: Tween(begin: 0.0, end: 1.0)
                              .animate(
                                CurvedAnimation(
                                  parent: animationController,
                                  curve: Interval(0.7, 0.8, curve: curve),
                                ),
                              )
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
                          child: _ColumnCell(
                            value: _d.ratedCount?.toString() ?? '',
                            title: 'Rated',
                            start: 0.7,
                            end: 0.9,
                            animationController: animationController,
                          ),
                        ),
                      ),
                      Opacity(
                          opacity: Tween(begin: 0.0, end: 1.0)
                              .animate(CurvedAnimation(
                                  parent: animationController,
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
                          child: _ColumnCell(
                            value: _d.popular?.toStringAsFixed(0) ?? '',
                            title: 'Popular',
                            start: 0.8,
                            end: 1.0,
                            animationController: animationController,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ));
  }
}
