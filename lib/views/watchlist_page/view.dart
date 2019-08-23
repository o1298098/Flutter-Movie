import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/customwidgets/hero_dialog_route.dart';
import 'package:movie/customwidgets/watchlistdetail.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/enums/genres.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/videolist.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:math' as math;

import 'action.dart';
import 'state.dart';

Widget buildView(
    WatchlistPageState state, Dispatch dispatch, ViewService viewService) {
  void _cellTapped(VideoListResult d) async {
    int index = state.tvshowList.results.indexOf(d);
    await Navigator.of(viewService.context, rootNavigator: true).push(
        PageRouteBuilder(
            opaque: false,
            barrierDismissible: true,
            barrierColor: Colors.black45,
            transitionDuration: Duration(milliseconds: 300),
            pageBuilder: (BuildContext context, Animation animation,
                Animation secondaryAnimation) {
              return SlideTransition(
                position: Tween(begin: Offset(0, 1), end: Offset(0, 0.2))
                    .animate(
                        CurvedAnimation(parent: animation, curve: Curves.ease)),
                child: WatchlistDetail(
                  initialIndex: index,
                  data: state.tvshowList,
                ),
              );
            }));
  }

  Widget _buildSwiper() {
    var _list = state.isMovie ? state.movieList : state.tvshowList;
    var _result = _list?.results ?? [];
    Widget _child = _result.length == 0
        ? Shimmer.fromColors(
            baseColor: Colors.grey[200],
            highlightColor: Colors.grey[100],
            child: Center(
              child: Container(
                width: Adapt.screenW() * .85,
                height: Adapt.screenH() / 2 + Adapt.px(80),
                margin:
                    EdgeInsets.only(right: Adapt.px(20), bottom: Adapt.px(70)),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(Adapt.px(50))),
              ),
            ),
          )
        : Swiper(
            key: ValueKey(_list),
            loop: false,
            physics: BouncingScrollPhysics(),
            controller: state.swiperController,
            itemCount: _result.length,
            viewportFraction: 0.85,
            scale: 0.85,
            onTap: (index) =>
                dispatch(WatchlistPageActionCreator.swiperCellTapped()),
            onIndexChanged: (index) => dispatch(
                WatchlistPageActionCreator.swiperChanged(_result[index])),
            itemBuilder: (ctx, index) {
              var _d = _result[index];
              return Container(
                  margin: EdgeInsets.only(right: Adapt.px(10)),
                  child: Hero(
                      tag: 'Background${_d.id}',
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: <Widget>[
                          Container(
                            height: Adapt.screenH() / 2 + Adapt.px(80),
                            alignment: Alignment.bottomRight,
                            margin: EdgeInsets.only(
                                right: Adapt.px(20), bottom: Adapt.px(70)),
                            decoration: BoxDecoration(
                                color: index.isEven
                                    ? Colors.amber
                                    : Colors.blueAccent,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    alignment: Alignment.bottomCenter,
                                    image: CachedNetworkImageProvider(
                                        ImageUrl.getUrl(
                                            _d.poster_path, ImageSize.w500))),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      blurRadius: 20,
                                      offset: Offset(-5, 12),
                                      color: Colors.black26)
                                ],
                                borderRadius:
                                    BorderRadius.circular(Adapt.px(50))),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                                right: Adapt.px(10), bottom: Adapt.px(60)),
                            width: Adapt.px(120),
                            height: Adapt.px(120),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(Adapt.px(30))),
                            child: Material(
                              color: Colors.transparent,
                              child: Text(
                                _d.vote_average.toString(),
                                style: TextStyle(
                                    color:
                                        Colors.tealAccent[700].withAlpha(200),
                                    fontSize: Adapt.px(50),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Container(
                            width: Adapt.px(60),
                            height: Adapt.px(60),
                            margin: EdgeInsets.only(bottom: Adapt.px(140)),
                            decoration: BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            child: Icon(Icons.star, color: Colors.yellow),
                          )
                        ],
                      )));
            },
          );
    return Container(
      height: Adapt.screenH() / 2 + Adapt.px(150),
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 600),
        child: _child,
      ),
    );
  }

  Widget _buildInfo() {
    Widget _child = state.selectMdeia == null
        ? Shimmer.fromColors(
            baseColor: Colors.grey[200],
            highlightColor: Colors.grey[100],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: Adapt.px(45),
                  width: Adapt.px(400),
                  color: Colors.grey[200],
                ),
                SizedBox(
                  height: Adapt.px(30),
                ),
                Container(
                  height: Adapt.px(24),
                  color: Colors.grey[200],
                ),
                SizedBox(
                  height: Adapt.px(8),
                ),
                Container(
                  height: Adapt.px(24),
                  color: Colors.grey[200],
                ),
                SizedBox(
                  height: Adapt.px(8),
                ),
                Container(
                  height: Adapt.px(24),
                  color: Colors.grey[200],
                ),
                SizedBox(
                  height: Adapt.px(8),
                ),
                Container(
                  height: Adapt.px(24),
                  width: Adapt.px(200),
                  color: Colors.grey[200],
                ),
                SizedBox(
                  height: Adapt.px(8),
                ),
              ],
            ),
          )
        : Column(
            key: ValueKey(state.selectMdeia),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(state.selectMdeia.title ?? state.selectMdeia.name,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: Adapt.px(45),
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: Adapt.px(20),
              ),
              Text(state.selectMdeia.genre_ids
                  .map((f) {
                    return Genres.genres[f];
                  })
                  .toList()
                  .join(' / ')),
              SizedBox(
                height: Adapt.px(20),
              ),
              Text(
                state.selectMdeia.overview,
                maxLines: 5,
              )
            ],
          );
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Adapt.px(50)),
      child: AnimatedSwitcher(
        //switchInCurve: Curves.easeIn,
        //switchOutCurve: Curves.easeOut,
        transitionBuilder: (w, a) {
          return SlideTransition(
            position: a.drive(Tween(begin: Offset(0, 0.2), end: Offset.zero)),
            child: FadeTransition(
              opacity: a,
              child: w,
            ),
          );
        },
        duration: Duration(milliseconds: 300),
        reverseDuration: Duration(milliseconds: 0),
        child: _child,
      ),
    );
  }

  Widget _buildmySeiper() {
    var _list = state.isMovie ? state.movieList : state.tvshowList;
    var _result = _list?.results ?? [];
    Widget _child = _result.length == 0
        ? Shimmer.fromColors(
            baseColor: Colors.grey[200],
            highlightColor: Colors.grey[100],
            child: Center(
              child: Container(
                width: Adapt.screenW() * .85,
                height: Adapt.screenH() / 2 + Adapt.px(80),
                margin:
                    EdgeInsets.only(right: Adapt.px(20), bottom: Adapt.px(70)),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(Adapt.px(50))),
              ),
            ),
          )
        : _SwiperView(
            key: ValueKey(_list),
            itemCount: _result.length,
            viewportFraction: 0.85,
            scale: 0.9,
            itemTapped: (index) =>
                dispatch(WatchlistPageActionCreator.swiperCellTapped()),
            onPageChanged: (index) => dispatch(
                WatchlistPageActionCreator.swiperChanged(_result[index])),
            itemBuilder: (ctx, index) {
              var _d = _result[index];
              return Container(
                  key: ValueKey(_d),
                  margin: EdgeInsets.only(right: Adapt.px(20)),
                  child: Hero(
                      tag: 'Background${_d.id}',
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: <Widget>[
                          Container(
                            height: Adapt.screenH() / 2 + Adapt.px(80),
                            alignment: Alignment.bottomRight,
                            margin: EdgeInsets.only(
                                right: Adapt.px(20), bottom: Adapt.px(70)),
                            decoration: BoxDecoration(
                                color: index.isEven
                                    ? Colors.amber
                                    : Colors.blueAccent,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    alignment: Alignment.bottomCenter,
                                    image: CachedNetworkImageProvider(
                                        ImageUrl.getUrl(
                                            _d.poster_path, ImageSize.w500))),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      blurRadius: 20,
                                      offset: Offset(-5, 12),
                                      color: Colors.black26)
                                ],
                                borderRadius:
                                    BorderRadius.circular(Adapt.px(50))),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                                right: Adapt.px(10), bottom: Adapt.px(60)),
                            width: Adapt.px(120),
                            height: Adapt.px(120),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(Adapt.px(30))),
                            child: Material(
                              color: Colors.transparent,
                              child: Text(
                                _d.vote_average.toString(),
                                style: TextStyle(
                                    color:
                                        Colors.tealAccent[700].withAlpha(200),
                                    fontSize: Adapt.px(50),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Container(
                            width: Adapt.px(60),
                            height: Adapt.px(60),
                            margin: EdgeInsets.only(bottom: Adapt.px(140)),
                            decoration: BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            child: Icon(Icons.star, color: Colors.yellow),
                          )
                        ],
                      )));
            },
          );
    return Container(
        height: Adapt.screenH() / 2 + Adapt.px(150),
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 600),
          child: _child,
        ));
  }

  Widget _buildBody() {
    TextStyle _selectTextStyle = TextStyle(
        color: Colors.black,
        fontSize: Adapt.px(45),
        fontWeight: FontWeight.bold);
    TextStyle _unselectTextStyle = TextStyle(
        color: Colors.black,
        fontSize: Adapt.px(30),
        fontWeight: FontWeight.bold);
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              InkWell(
                onTap: () {
                  if (!state.isMovie) {
                    dispatch(WatchlistPageActionCreator.widthChanged(true));
                    state.animationController.reverse();
                  }
                },
                child: Container(
                  alignment: Alignment.bottomCenter,
                  height: Adapt.px(60),
                  width: Adapt.px(250),
                  child: Text(
                    I18n.of(viewService.context).movies,
                    style:
                        state.isMovie ? _selectTextStyle : _unselectTextStyle,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  if (state.isMovie) {
                    dispatch(WatchlistPageActionCreator.widthChanged(false));
                    state.animationController.forward(from: 0.0);
                  }
                },
                child: Container(
                    alignment: Alignment.bottomCenter,
                    height: Adapt.px(60),
                    width: Adapt.px(250),
                    child: Text(
                      I18n.of(viewService.context).tvShows,
                      style:
                          state.isMovie ? _unselectTextStyle : _selectTextStyle,
                    )),
              ),
              Expanded(
                child: Container(),
              ),
              Container(
                width: Adapt.px(50),
                height: Adapt.px(50),
                decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(Adapt.px(10))),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.of(viewService.context).pop(),
                ),
              ),
              SizedBox(
                width: Adapt.px(30),
              )
            ],
          ),
          SizedBox(
            height: Adapt.px(10),
          ),
          Container(
            alignment: Alignment.centerLeft,
            width: Adapt.px(500),
            child: SlideTransition(
              position: Tween(begin: Offset.zero, end: Offset(1, 0)).animate(
                  CurvedAnimation(
                      curve: Curves.ease, parent: state.animationController)),
              child: Container(
                width: Adapt.px(250),
                height: Adapt.px(20),
                decoration:
                    BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
              ),
            ),
          ),
          SizedBox(
            height: Adapt.px(80),
          ),
          _buildmySeiper(),
          //_buildSwiper(),
          _buildInfo(),
        ],
      ),
    );
  }

  return Scaffold(backgroundColor: Colors.white, body: _buildBody());
}

class _SwiperView extends StatefulWidget {
  final Key key;
  final Widget Function(BuildContext, int) itemBuilder;
  final Function(int) itemTapped;
  final Function(int) onPageChanged;
  final int itemCount;
  final double viewportFraction;
  final double scale;
  final ScrollPhysics physics;
  _SwiperView(
      {this.key,
      this.itemBuilder,
      this.itemCount,
      this.viewportFraction = 1.0,
      this.scale = 1.0,
      this.physics = const BouncingScrollPhysics(),
      this.itemTapped,
      this.onPageChanged});
  @override
  _SwiperViewState createState() => _SwiperViewState();
}

class _SwiperViewState extends State<_SwiperView> {
  PageController controller;
  double pageOffset = 0;
  double pxOffset = 0;

  double _itemswidht;
  @override
  void initState() {
    _itemswidht = Adapt.screenW() * widget.viewportFraction;
    controller =
        PageController(viewportFraction: widget.viewportFraction ?? 1.0)
          ..addListener(() {
            setState(() {
              pageOffset = controller.page;
              pxOffset = controller.offset;
            });
          });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      controller: controller,
      physics: widget.physics,
      itemBuilder: (context, index) {
        double _now = (_itemswidht * index - pxOffset) / _itemswidht;
        double _offset = pageOffset - index;
        double _scale = 1 - _now.abs() / 4;
        double _gauss = math.exp(-(math.pow((_offset.abs() - 0.5), 2) / 0.08));
        return Transform.translate(
          offset: Offset(-30 * _gauss * _offset.sign, 0),
          child: Transform.scale(
            scale: _now.abs() == 0
                ? 1.0
                : _scale < widget.scale ? widget.scale : _scale,
            child: GestureDetector(
              onTap: () => widget.itemTapped(index),
              child: widget.itemBuilder(context, index),
            ),
          ),
        );
      },
      onPageChanged: widget.onPageChanged,
      itemCount: widget.itemCount,
    );
  }
}
