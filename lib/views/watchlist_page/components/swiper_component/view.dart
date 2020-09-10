import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/base_api_model/user_media.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/views/watchlist_page/action.dart';
import 'package:shimmer/shimmer.dart';

import 'dart:math' as math;
import 'state.dart';

Widget buildView(
    SwiperState state, Dispatch dispatch, ViewService viewService) {
  final List<UserMedia> _list = state.isMovie
      ? (state?.movies?.data ?? [])
      : (state?.tvshows?.data ?? []);

  return Container(
      height: Adapt.screenH() / 2 + Adapt.px(150),
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 600),
        child: _list.length == 0
            ? _ShimmerCell()
            : _SwiperView(
                key: ValueKey(_list),
                itemCount: _list.length,
                viewportFraction: 0.85,
                physics: BouncingScrollPhysics(),
                scale: 0.9,
                itemTapped: (index) =>
                    dispatch(WatchlistPageActionCreator.swiperCellTapped()),
                onPageChanged: (index) => dispatch(
                    WatchlistPageActionCreator.swiperChanged(_list[index])),
                itemBuilder: (ctx, index) =>
                    _SwiperCell(data: _list[index], index: index),
              ),
      ));
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

class _SwiperCell extends StatelessWidget {
  final UserMedia data;
  final int index;
  const _SwiperCell({this.data, this.index});
  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey(data),
      margin: EdgeInsets.only(right: Adapt.px(20)),
      child: Hero(
        tag: 'Background${data.mediaId}',
        child: Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            Container(
              height: Adapt.screenH() / 2 + Adapt.px(80),
              alignment: Alignment.bottomRight,
              margin:
                  EdgeInsets.only(right: Adapt.px(20), bottom: Adapt.px(70)),
              decoration: BoxDecoration(
                color: index.isEven ? Colors.amber : Colors.blueAccent,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomCenter,
                  image: CachedNetworkImageProvider(
                    ImageUrl.getUrl(data.photoUrl, ImageSize.w500),
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
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                right: Adapt.px(10),
                bottom: Adapt.px(60),
              ),
              width: Adapt.px(120),
              height: Adapt.px(120),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  Adapt.px(30),
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: Text(
                  data.rated.toString(),
                  style: TextStyle(
                      color: Colors.tealAccent[700].withAlpha(200),
                      fontSize: Adapt.px(50),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              width: Adapt.px(60),
              height: Adapt.px(60),
              margin: EdgeInsets.only(bottom: Adapt.px(140)),
              decoration:
                  BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: Icon(Icons.star, color: Colors.yellow),
            )
          ],
        ),
      ),
    );
  }
}

class _ShimmerCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Shimmer.fromColors(
      baseColor: _theme.primaryColorDark,
      highlightColor: _theme.primaryColorLight,
      child: Center(
        child: Container(
          width: Adapt.screenW() * .85,
          height: Adapt.screenH() / 2 + Adapt.px(80),
          margin: EdgeInsets.only(right: Adapt.px(20), bottom: Adapt.px(70)),
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(Adapt.px(50))),
        ),
      ),
    );
  }
}
