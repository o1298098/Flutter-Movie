import 'dart:collection';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/imagemodel.dart';
import 'package:movie/views/tvdetail_page/action.dart';
import 'package:parallax_image/parallax_image.dart';
import 'package:shimmer/shimmer.dart';

import 'state.dart';

Widget buildView(
    ImagesState state, Dispatch dispatch, ViewService viewService) {
  final Random random = new Random(DateTime.now().millisecondsSinceEpoch);
  List<ImageData> _allimage;
  Widget _buildImageCell(int index) {
    final d = _allimage[index];
    double w = (Adapt.screenW() - Adapt.px(100)) / 2;
    double h = w / d.aspectRatio;
    return GestureDetector(
      key: ValueKey(d.filePath),
      onTap: () => dispatch(
          TVDetailPageActionCreator.onImageCellTapped(index, _allimage)),
      child: Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
          color: Color.fromRGBO(random.nextInt(255), random.nextInt(255),
              random.nextInt(255), random.nextDouble()),
        ),
        child: ParallaxImage(
            extent: h,
            image: CachedNetworkImageProvider(
                ImageUrl.getUrl(d.filePath, ImageSize.w400))),
      ),
    );
  }

  Widget _buildShimmerImageCell(double h) {
    double w = (Adapt.screenW() - Adapt.px(100)) / 2;
    return Shimmer.fromColors(
      baseColor: Colors.grey[200],
      highlightColor: Colors.grey[100],
      child: Container(
        width: w,
        height: h,
        color: Colors.grey[200],
      ),
    );
  }

  Widget _getImageBody() {
    var hset = new HashSet<ImageData>()
      ..addAll(state.backdrops)
      ..addAll(state.posters);
    _allimage = hset.toList();
    if (_allimage.length > 0)
      return SliverStaggeredGrid.countBuilder(
        crossAxisCount: 4,
        staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
        mainAxisSpacing: Adapt.px(20),
        crossAxisSpacing: Adapt.px(20),
        itemCount: _allimage.length,
        itemBuilder: (BuildContext contxt, int index) {
          return _buildImageCell(index);
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
          return _buildShimmerImageCell(80.0 * index);
        },
      );
  }

  return Container(child: Builder(builder: (BuildContext context) {
    return CustomScrollView(slivers: <Widget>[
      SliverOverlapInjector(
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
      ),
      _getImageBody()
    ]);
  }));
}
