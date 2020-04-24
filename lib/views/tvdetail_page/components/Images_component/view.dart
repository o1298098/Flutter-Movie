import 'dart:collection';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/imagemodel.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/views/tvdetail_page/action.dart';
import 'package:parallax_image/parallax_image.dart';
import 'package:shimmer/shimmer.dart';

import 'state.dart';

Widget buildView(
    ImagesState state, Dispatch dispatch, ViewService viewService) {
  return Container(child: Builder(builder: (BuildContext context) {
    return CustomScrollView(slivers: <Widget>[
      SliverOverlapInjector(
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
      ),
      _ImageBody(
        backdrops: state.backdrops,
        posters: state.posters,
        dispatch: dispatch,
      )
    ]);
  }));
}

class _ShimmerImageCell extends StatelessWidget {
  final double height;
  const _ShimmerImageCell({this.height});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    double w = (Adapt.screenW() - Adapt.px(100)) / 2;
    return Shimmer.fromColors(
      baseColor: _theme.primaryColorDark,
      highlightColor: _theme.primaryColorLight,
      child: Container(
        width: w,
        height: height,
        color: Colors.grey[200],
      ),
    );
  }
}

class _ImageCell extends StatelessWidget {
  final int index;
  final ImageData data;
  final Function(ImageData) onTap;
  const _ImageCell({this.data, this.index, this.onTap});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    double w = (Adapt.screenW() - Adapt.px(100)) / 2;
    double h = w / data.aspectRatio;
    return GestureDetector(
      key: ValueKey(data.filePath),
      onTap: () => onTap(data),
      child: Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
          color: _theme.primaryColorDark,
        ),
        child: ParallaxImage(
            extent: h,
            image: CachedNetworkImageProvider(
                ImageUrl.getUrl(data.filePath, ImageSize.w400))),
      ),
    );
  }
}

class _ImageBody extends StatelessWidget {
  final List<ImageData> backdrops;
  final List<ImageData> posters;
  final Dispatch dispatch;
  const _ImageBody({this.backdrops, this.dispatch, this.posters});
  @override
  Widget build(BuildContext context) {
    final hset = new HashSet<ImageData>()..addAll(backdrops)..addAll(posters);
    final _allimage = hset.toList();
    if (_allimage.length > 0)
      return SliverStaggeredGrid.countBuilder(
        crossAxisCount: 4,
        staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
        mainAxisSpacing: Adapt.px(20),
        crossAxisSpacing: Adapt.px(20),
        itemCount: _allimage.length,
        itemBuilder: (BuildContext contxt, int index) {
          return _ImageCell(
            index: index,
            data: _allimage[index],
            onTap: (e) => dispatch(
                TVDetailPageActionCreator.onImageCellTapped(index, _allimage)),
          );
        },
      );
    else
      return SliverStaggeredGrid.countBuilder(
        crossAxisCount: 4,
        staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
        mainAxisSpacing: Adapt.px(20),
        crossAxisSpacing: Adapt.px(20),
        itemCount: 6,
        itemBuilder: (BuildContext contxt, int index) {
          return _ShimmerImageCell(height: 80.0 * index);
        },
      );
  }
}
