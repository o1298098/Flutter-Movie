import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/imagemodel.dart';
import 'package:movie/style/themestyle.dart';

import 'state.dart';

Widget buildView(
    GalleryPageState state, Dispatch dispatch, ViewService viewService) {
  return Builder(builder: (context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    Widget _buildImageCell(ImageData d, int index) {
      double width = Adapt.screenW() / 2;
      return Hero(
        key: ValueKey('image${d.filePath}'),
        tag: 'image${d.filePath}',
        child: Container(
          width: width,
          height: width / d.aspectRatio,
          decoration: BoxDecoration(
              color: _theme.primaryColorDark,
              borderRadius: BorderRadius.circular(Adapt.px(20)),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                      ImageUrl.getUrl(d.filePath, ImageSize.w300)))),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: _theme.backgroundColor,
        brightness: _theme.brightness,
        iconTheme: _theme.iconTheme,
        title: Text(
          'Gallery',
          style: _theme.textTheme.body1,
        ),
      ),
      body: StaggeredGridView.countBuilder(
        primary: false,
        crossAxisCount: 4,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
        itemCount: state.images.length,
        itemBuilder: (context, index) =>
            _buildImageCell(state.images[index], index),
        staggeredTileBuilder: (index) =>
            new StaggeredTile.count(2, index.isEven ? 4 : 3),
      ),
    );
  });
}
