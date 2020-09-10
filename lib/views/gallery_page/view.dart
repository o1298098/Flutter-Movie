import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/image_model.dart';
import 'package:movie/style/themestyle.dart';

import 'state.dart';

Widget buildView(
    GalleryPageState state, Dispatch dispatch, ViewService viewService) {
  return Builder(builder: (context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: _theme.backgroundColor,
        brightness: _theme.brightness,
        iconTheme: _theme.iconTheme,
        title: Text(
          'Gallery',
          style: _theme.textTheme.bodyText1,
        ),
      ),
      body: StaggeredGridView.countBuilder(
        primary: false,
        crossAxisCount: 4,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
        itemCount: state.images.length,
        itemBuilder: (context, index) =>
            _ImageCell(data: state.images[index], index: index),
        staggeredTileBuilder: (index) =>
            new StaggeredTile.count(2, index.isEven ? 4 : 3),
      ),
    );
  });
}

class _ImageCell extends StatelessWidget {
  final ImageData data;
  final int index;
  const _ImageCell({this.data, this.index});
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    final double width = Adapt.screenW() / 2;
    return Hero(
      key: ValueKey('image${data.filePath}'),
      tag: 'image${data.filePath}',
      child: Container(
        width: width,
        height: width / data.aspectRatio,
        decoration: BoxDecoration(
          color: _theme.primaryColorDark,
          borderRadius: BorderRadius.circular(Adapt.px(20)),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: CachedNetworkImageProvider(
                ImageUrl.getUrl(data.filePath, ImageSize.w300)),
          ),
        ),
      ),
    );
  }
}
